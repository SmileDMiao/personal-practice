class Food < ActiveRecord::Base

  validates_presence_of :name, :category, :color
  validates :number, numericality: {greater_than_or_equal_to: 0 }

end
