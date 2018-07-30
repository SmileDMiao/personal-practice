class Food < ApplicationRecord

  validates_presence_of :name, :category
  validates :number, numericality: {greater_than_or_equal_to: 0 }

  paginates_per 10

  scope :search, ->(search) { where(:name => search)}

end
