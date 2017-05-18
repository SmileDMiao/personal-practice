class Section < ApplicationRecord

  has_many :nodes

  validates_presence_of :name, :sort

end