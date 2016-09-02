class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :node
  has_many :comments, dependent: :destroy

  validates_presence_of :title, :body, :node_id


  scope :popular,       -> { order(likes_count: :desc) }


  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

  #创建之后创建提醒信息
  after_commit :create_reply_notify, on: :create
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
    default_note = { notify_type: 'article', target_type: 'Article', target_id: article.id, actor_id: article.user_id }
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

    true
  end

  # 待重写
  # include PgSearch
  # pg_search_scope :chinese_search,
  #                 :against => [:title, :body],
  #                 :using => {
  #                     tsearch: {
  #                         dictionary: 'testzhcfg',:prefix => true # 在数据库中设置好的“搜索配置”的名称
  #                     }
  #                 }
  #pg_search_scope :search_by_title_or_body, :against => [:title, :body]

end