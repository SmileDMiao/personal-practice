class ActiveRecord::Base

  #使用uuid作为主键代替mysql的id
  before_create :set_uuid

  def set_uuid
    self.id = UUID.generate(:compact)
  end
  
end