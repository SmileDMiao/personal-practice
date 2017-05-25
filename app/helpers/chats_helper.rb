module ChatsHelper

  def message_user_name(message)
    if message.send_user_id == current_user.id
      return current_user.full_name
    else
      return User.find(message.send_user_id).full_name
    end
  end

  def message_user_avatar(message)
    if message.send_user_id == current_user.id
      image = image_tag(current_user.avatar.url, class: 'direct-chat-img')
      raw image
    else
      user = User.find(message.send_user_id)
      image = image_tag(user.avatar.url, class: 'direct-chat-img')
      raw image
    end
  end

  def message_user_name_chat(message, current_user)
    if message.send_user_id == current_user.id
      return current_user.full_name
    else
      return User.find(message.send_user_id).full_name
    end
  end

  def message_user_avatar_chat(message, current_user)
    if message.send_user_id == current_user.id
      image = image_tag(current_user.avatar.url, class: 'direct-chat-img')
      raw image
    else
      user = User.find(message.send_user_id)
      image = image_tag(user.avatar.url, class: 'direct-chat-img')
      raw image
    end
  end

end
