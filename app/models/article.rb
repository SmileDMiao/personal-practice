class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :node
  has_many :comments

end