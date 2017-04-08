class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :node
  has_many :comments, dependent: :destroy

  paginates_per 20

  validates_presence_of :title, :body, :node_id


  scope :popular, -> { order(likes_count: :desc) }
  scope :no_comment, -> { where(comment_count: 0).order(created_at: :desc) }
  scope :time_desc, -> {order(created_at: :desc)}


  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

  #创建之后创建提醒信息
  after_commit :create_reply_notify, :publish_article, on: :create

  def publish_article
    Publisher.publish("Articles", self.attributes)
  end

  def create_reply_notify
    NotifyArticleJob.perform_later(id)
  end

  def self.notify_article_created(article_id)
    article = Article.find_by_id(article_id)
    return unless article && article.user

    follower_ids = article.user.follower_ids.uniq
    return if follower_ids.empty?

    notified_user_ids = article.mentioned_user_ids

    # 给关注者发通知
    default_note = {notify_type: 'article', target_type: 'Article', target_id: article.id, actor_id: article.user_id}
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
            notify_type: 'mention',
            actor_id: article.user_id,
            user_id: user_id,
            target_type: self.class.name,
            target_id: self.id
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

  # postgres数据库-全文搜索
  include PgSearch
  # 单表搜索
  pg_search_scope :chinese_search,
                  :against => [:title, :body],
                  :using => {
                      tsearch: {
                          # dictionary: 'zhcnsearch',
                          :prefix => true
                      }
                  }

  # 多表搜索
  multisearchable :against => [:title, :body]


  #elasticsearch 全文搜索
  # include Searchable
  #
  # mapping do
  #   indexes :title, term_vector: :yes
  #   indexes :body, term_vector: :yes
  # end
  #
  # def as_indexed_json(_options = {})
  #   {
  #       title: self.title,
  #       body: self.body,
  #       node_name: self.node.name
  #   }
  # end

end