class Node < ActiveRecord::Base

  acts_as_cached(:version => 1, :expires_in => 1.week)

  has_many :articles
  belongs_to :section

  validates_presence_of :name, :section_id, :sort, :summary

end