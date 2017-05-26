class ChatChannel < ApplicationCable::Channel
  def subscribed
    logger.info "current connection: #{ActionCable.server.connections.count}"
    stream_from "chat_channel#{self.current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create(data['message'])
    ActionCable.server.broadcast "chat_channel#{self.current_user.id}", message: render_message_from(message)
    ActionCable.server.broadcast "chat_channel#{message.receive_user_id}", message: render_message_to(message)
  end

  private

  def render_message_from(message)
    ApplicationController.renderer.render(partial: 'chats/chat', locals: { message: message, current_user: self.current_user })
  end

  def render_message_to(message)
    ApplicationController.renderer.render(partial: 'chats/chat', locals: { message: message, current_user: User.find(message.receive_user_id) })
  end

end
