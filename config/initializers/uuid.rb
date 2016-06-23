class ActiveRecord::Base

  before_create :set_uuid

  def set_uuid
    self.id = UUID.generate(:compact)
  end
  
end