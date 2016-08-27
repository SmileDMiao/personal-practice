class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :article

  validates_presence_of :body

  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

end