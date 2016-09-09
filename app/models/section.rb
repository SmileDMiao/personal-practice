class Section < ActiveRecord::Base

  acts_as_cached(:version => 1, :expires_in => 1.week)

  has_many :nodes

  validates_presence_of :name, :sort

end