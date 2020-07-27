# frozen_string_literal: true

class Publisher
  class << self
    def publish(exchange, message = {})
      x = channel.fanout("Article.#{exchange}")
      x.publish(message.to_json)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new.tap do |c|
        c.start
      end
    end
  end
end
