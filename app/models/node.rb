class Node < ActiveRecord::Base

  has_many :articles
  belongs_to :section

end