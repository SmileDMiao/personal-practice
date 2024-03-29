# frozen_string_literal: true

class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attr_accessor :new_password, :confirm_password

  mount_uploader :avatar, AvatarUploader
  has_secure_password

  ALLOW_LOGIN_CHARS_REGEXP = /\A[A-Za-z0-9\-_.]+\z/
  validates :full_name, format: {with: ALLOW_LOGIN_CHARS_REGEXP, message: "只允许数字、大小写字母、中横线、下划线"},
                        presence: true,
                        uniqueness: true

  validates :email, email: true,
                    presence: true,
                    uniqueness: true

  validates :item, acceptance: true

  before_create do
    self.auth_token = generate_token
    self.avatar_name = full_name
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def letter_avatar_url(size)
    letter_avatar_address = LetterAvatar.generate(full_name, size)
    avatar_address = Rails.root + letter_avatar_address
    File.open(avatar_address)
  end

  # letter avatar 生成默认头像
  def large_avatar_url
    letter_avatar_url(240)
  end

  def github_url
    return "" if github.blank?

    "https://github.com/#{github.split("/").last}"
  end

  def twitter_url
    return "" if twitter.blank?

    "https://twitter.com/#{twitter}"
  end

  def github_repositories
    cache_key = github_repositories_cache_key
    items = $file_store.read(cache_key)
    if items.nil?
      FetchGithubRepoWorker.perform_async(id)
      items = []
    end
    items
  end

  def github_repositories_cache_key
    "github-repos:#{github}:1"
  end

  def github_repo_api_url
    github_login = github
    resource_name = "users"
    "https://api.github.com/#{resource_name}/#{github_login}/repos?type=owner&sort=pushed&client_id=#{Setting.github_token}&client_secret=#{Setting.github_secret}"
  end

  # 获取github项目列表并存入文件缓存
  def self.fetch_github_repositories(user_id)
    user = User.find_by_id(user_id)
    return unless user

    url = user.github_repo_api_url
    begin
      json = Timeout.timeout(10) { open(url).read }
    rescue => e
      Rails.logger.error("GitHub Repositiory fetch Error: #{e}")
      return false
    end

    items = JSON.parse(json)
    items = items.collect do |a1|
      {
        name: a1["name"],
        url: a1["html_url"],
        watchers: a1["watchers"],
        language: a1["language"],
        description: a1["description"]
      }
    end
    items = items.sort { |a, b| b[:watchers] <=> a[:watchers] }.take(10)
    $file_store.write(user.github_repositories_cache_key, items, expires_in: 15.days)
    items
  end

  # 喜欢文章
  def favorite_article(article_id)
    favorite_article_ids << article_id
    save
  end

  # 取消喜欢文章
  def unfavorite_article(article_id)
    favorite_article_ids.delete(article_id)
    save
  end

  def followed?(user)
    following_ids.include?(user.id)
  end

  # follow用户
  def follow_user(user)
    following_ids << user.id
    self.following_ids = following_ids.uniq
    save
    user.follower_ids << id
    user.follower_ids = user.follower_ids.uniq
    user.save
    Notification.notify_follow(user.id, id)
  end

  # 取消follow用户
  def unfollow_user(user)
    following_ids.delete(user.id)
    save
    user.follower_ids.delete(id)
    user.save
  end

  def following
    User.where(id: following_ids)
  end

  def followers
    User.where(id: follower_ids)
  end

  def read_article(article, opts = {})
    return if article.blank?

    # pluck: select id form comments
    opts[:comment_ids] ||= article.comment.pluck(:id)

    range_sql = "
      (target_type = 'Topic' AND target_id = ?) or
      (target_type = 'Reply' AND target_id in (?))
    "
    notifications.where(range_sql, article.id, opts[:comment_ids]).destroy_all
  end

  def admin?
    Setting.admin_emails.include?(email)
  end
end
