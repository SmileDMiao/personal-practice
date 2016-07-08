class User < ActiveRecord::Base
  #这个方法是rails自带的，密码字段必须是password_digest，在页面上必须是password + password_confirmation
  has_secure_password

  validates_presence_of :full_name, :email
  validates :email, email: true

end
