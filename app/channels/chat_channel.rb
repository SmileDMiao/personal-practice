class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    puts '---' * 20
    # ActionCable.server.broadcast "room_channel", message: data['message']
    # Message.create! message: data['message']
    ActionCable.server.broadcast "chat_channel", message: data['message']
  end
end
