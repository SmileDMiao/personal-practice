class User < ActiveRecord::Base

  has_many :articles

  mount_uploader :avatar, AvatarUploader
  #这个方法是rails自带的，密码字段必须是password_digest，在页面上必须是password + password_confirmation
  has_secure_password

  validates_presence_of :full_name, :email
  validates :email, email: true
  validates_uniqueness_of :full_name, :email

  before_save do
    self.auth_token = generate_token
    self.avatar_name = self.full_name
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def letter_avatar_url(size)
    letter_avatar_address = LetterAvatar.generate(self.full_name, size)
    avatar_address = '/home/miao/hand/source/personal/personal-practice/' + letter_avatar_address
    File.open(avatar_address)
  end

  # letter avatar 生成默认头像
  def large_avatar_url
      self.letter_avatar_url(192)
  end

end
