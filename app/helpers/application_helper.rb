module ApplicationHelper


  def smile
    SecureRandom.urlsafe_base64
  end
end
