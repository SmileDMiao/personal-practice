class User < ActiveRecord::Base

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :notifications, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  #这个方法是rails自带的，密码字段必须是password_digest，在页面上必须是password + password_confirmation
  has_secure_password

  validates_presence_of :full_name, :email
  validates :email, email: true
  validates_uniqueness_of :full_name, :email

  before_create do
    self.auth_token = generate_token
    self.avatar_name = self.full_name
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def letter_avatar_url(size)
    letter_avatar_address = LetterAvatar.generate(self.full_name, size)
    avatar_address = Rails.root + letter_avatar_address
    File.open(avatar_address)
  end

  # letter avatar 生成默认头像
  def large_avatar_url
      self.letter_avatar_url(192)
  end

  def github_url
    return '' if github.blank?
    "https://github.com/#{github.split('/').last}"
  end

  def twitter_url
    return '' if twitter.blank?
    "https://twitter.com/#{twitter}"
  end

  def github_repositories
    cache_key = github_repositories_cache_key
    items = $file_store.read(cache_key)
    if items.nil?
      FetchGithubRepoJob.perform_later(id)
      items = []
    end
    items
  end

  def github_repositories_cache_key
    "github-repos:#{github}:1"
  end

  def github_repo_api_url
    github_login = self.github
    resource_name = 'users'
    "https://api.github.com/#{resource_name}/#{github_login}/repos?type=owner&sort=pushed&client_id=91726ee4170d8e2679ec&client_secret=13c7e55e8e53c57a399181e96ea3a55a3fdd9c7c"
  end

  #获取github项目列表并存入文件缓存
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
          name: a1['name'],
          url: a1['html_url'],
          watchers: a1['watchers'],
          language: a1['language'],
          description: a1['description']
      }
    end
    items = items.sort { |a, b| b[:watchers] <=> a[:watchers] }.take(10)
    $file_store.write(user.github_repositories_cache_key, items, expires_in: 15.days)
    items
  end

  #喜欢文章
  def favorite_article(article_id)
    favorite_article_ids << article_id
    save
  end

  #取消喜欢文章
  def unfavorite_article(article_id)
    favorite_article_ids.delete(article_id)
    save
  end

  def followed?(user)
    following_ids.include?(user.id)
  end

  #follow用户
  def follow_user(user)
    following_ids << user.id
    save
    user.follower_ids << id
    user.save
  end

  #取消follow用户
  def unfollow_user(user)
    following_ids.delete(user.id)
    save
    user.follower_ids.delete(id)
    user.save
  end

  def following
    User.where(id: self.following_ids)
  end

  def followers
    User.where(id: self.follower_ids)
  end

end
