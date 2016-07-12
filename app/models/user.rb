class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  #这个方法是rails自带的，密码字段必须是password_digest，在页面上必须是password + password_confirmation
  has_secure_password

  validates_presence_of :full_name, :email
  validates :email, email: true
  validates_uniqueness_of :full_name, :email

  before_create do
    self.auth_token = generate_token
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

end
