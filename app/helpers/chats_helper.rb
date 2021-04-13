# frozen_string_literal: true

module ChatsHelper
  def message_user_name(message)
    if message.send_user_id == current_user.id
      current_user.full_name
    else
      User.find(message.send_user_id).full_name
    end
  end

  def message_user_avatar(message)
    if message.send_user_id == current_user.id
      image = image_tag(current_user.avatar.url, class: "direct-chat-img")
    else
      user = User.find(message.send_user_id)
      image = image_tag(user.avatar.url, class: "direct-chat-img")
    end
    raw image
  end

  def message_user_name_chat(message, current_user)
    if message.send_user_id == current_user.id
      current_user.full_name
    else
      User.find(message.send_user_id).full_name
    end
  end

  def message_user_avatar_chat(message, current_user)
    if message.send_user_id == current_user.id
      image = image_tag(current_user.avatar.url, class: "direct-chat-img")
    else
      user = User.find(message.send_user_id)
      image = image_tag(user.avatar.url, class: "direct-chat-img")
    end
    raw image
  end
end
