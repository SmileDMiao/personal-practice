class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :node
  has_many :comments, dependent: :destroy

  validates_presence_of :title, :body, :node_id

  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

  include PgSearch
  pg_search_scope :chinese_search,
                  :against => [:title, :body],
                  :using => {
                      tsearch: {
                          dictionary: 'testzhcfg',:prefix => true # 在数据库中设置好的“搜索配置”的名称
                      }
                  }
  #pg_search_scope :search_by_title_or_body, :against => [:title, :body]

end