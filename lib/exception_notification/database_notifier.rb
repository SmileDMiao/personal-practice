# frozen_string_literal: true

# 异常通知
module ExceptionNotifier
  class DatabaseNotifier
    def initialize(_options)
      # do something with the options...
    end

    def call(exception, _options = {})
      # send the notification
      @title = exception.message
      messages = []
      messages << exception.inspect
      unless exception.backtrace.blank?
        messages << '\n'
        messages << exception.backtrace
      end

      ExceptionLog.create(title: @title, body: messages.join('\n'))
      Rails.logger.info '\n================================================'
      Rails.logger.info messages.join('\n')
      Rails.logger.info '================================================\n'
    end
  end
end
