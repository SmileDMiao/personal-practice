# frozen_string_literal: true

class Article < ApplicationRecord
  include Elasticsearch::Model
  include Searchable
  include Wisper::Publisher

  belongs_to :user
  belongs_to :node
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true

  paginates_per 20

  validates_presence_of :title, :body, :node_id

  scope :popular, -> { order(likes_count: :desc) }
  scope :no_comment, -> { where(comment_count: 0).order(created_at: :desc) }
  scope :time_desc, -> { order(created_at: :desc) }

  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

  # 创建之后创建提醒信息
  after_commit :create_reply_notify, on: :create

  # Test of RabbitMq
  def publish_article
    Publisher.publish("Articles", attributes)
  end

  def create_reply_notify
    NotifyArticleWorker.perform_async(id)
    publish(:article_create, self)
  end

  def self.notify_article_created(article_id)
    article = Article.find_by_id(article_id)
    return unless article && article&.user

    follower_ids = article.user.follower_ids.uniq
    return if follower_ids.empty?

    notified_user_ids = article.mentioned_user_ids

    # 给关注者发通知
    default_note = {notify_type: "article", target_type: "Article", target_id: article.id, actor_id: article.user_id}
    Notification.bulk_insert do |worker|
      follower_ids.each do |uid|
        # 排除同一个回复过程中已经提醒过的人
        next if notified_user_ids.include?(uid)
        # 排除回帖人
        next if uid == article.user_id
        note = default_note.merge(user_id: uid)
        worker.add(note)
      end
    end

    Notification.bulk_insert(set_size: 100) do |worker|
      notified_user_ids.each do |user_id|
        note = {
          notify_type: "mention",
          actor_id: article.user_id,
          user_id: user_id,
          target_type: self.class.name,
          target_id: id
        }
        worker.add(note)
      end
    end

    true
  end

  def update_last_reply(comment)
    return false if comment.blank?
    self.comment_count = comments.count
    save
  end

  index_name "personal"
  document_type "articles"

  mapping do
    indexes :title, term_vector: :yes
    indexes :body, term_vector: :yes
  end

  def as_indexed_json(options = {})
    as_json(only: ["title", "body"])
  end
end
