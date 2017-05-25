class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_channel#{self.current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create(data['message'])
    ActionCable.server.broadcast "chat_channel#{self.current_user.id}", message: render_message(message)
    ActionCable.server.broadcast "chat_channel#{message.receive_user_id}", message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'chats/chat', locals: { message: message, current_user: self.current_user })
  end

end
