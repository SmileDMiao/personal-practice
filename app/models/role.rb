class Role < ApplicationRecord

  has_many :permissions, dependent: :destroy
  has_and_belongs_to_many :users

end
