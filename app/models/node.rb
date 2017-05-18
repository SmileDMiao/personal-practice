class Node < ApplicationRecord

  has_many :articles
  belongs_to :section

  validates_presence_of :name, :section_id, :sort, :summary

end