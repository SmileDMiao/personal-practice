class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :node
  has_many :comments, dependent: :destroy

  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

end