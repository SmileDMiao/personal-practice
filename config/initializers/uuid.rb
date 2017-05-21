class ActiveRecord::Base

  #可以使用mysql的uuid函数，但是比较麻烦,pg比较方便
  #使用uuid作为主键代替database的自增长id
  before_create :set_uuid

  def set_uuid
    # in rails5, this can effect schema_migrations and here skip it
    self.id = UUID.generate(:compact) unless self.class.name == 'ActiveRecord::SchemaMigration'
  end

end