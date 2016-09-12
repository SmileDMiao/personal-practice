class Section < ActiveRecord::Base

  has_many :nodes

  validates_presence_of :name, :sort

end