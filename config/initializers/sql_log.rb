#config/initializers/sql_log.rb
# 先把默认的subscriber去掉。
# Lograge.module_eval do
#   ActiveSupport::LogSubscriber.log_subscribers.each do |subscriber|
#     case subscriber
#     when ActiveRecord::LogSubscriber
#       unsubscribe(:active_record, subscriber)
#     end
#   end
# end

# 自己实现一个subscriber
module SQLLog
  class LogSubscriber < ActiveSupport::LogSubscriber
    IGNORE_PAYLOAD_NAMES = ["SCHEMA", "EXPLAIN"]

    def initialize
      super
    end

    def self.runtime=(value)
      ActiveRecord::RuntimeRegistry.sql_runtime = value
    end

    def self.runtime
      ActiveRecord::RuntimeRegistry.sql_runtime ||= 0
    end

    def self.reset_runtime
      rt, self.runtime = runtime, 0
      rt
    end

    def sql(event)
      self.class.runtime += event.duration

      payload = event.payload

      return if IGNORE_PAYLOAD_NAMES.include?(payload[:name])
      return if payload[:cached]

      name = payload[:name]
      name  = "CACHE #{name}" if payload[:cached]
      binds = nil
      uuid = Thread.current[:uuid] || nil

      unless (payload[:binds] || []).empty?
        casted_params = type_casted_binds(payload[:type_casted_binds])
        binds = "  " + payload[:binds].zip(casted_params).map { |attr, value|
          render_bind(attr, value)
        }.inspect
      end

      log = {
        values: {
          name: payload[:name] || '',
          duration: event.duration.round(1) || '',
          binds: binds || '',
          message: payload[:sql] || '',
          uuid: uuid || '',
          datetime: event.time.to_s || '',
          type: 'Sql'
        }
      }

      # $influxdb.write_point("sql_log", log)
      logger.debug log
    end

    private

    def logger
      ActiveSupport::Logger.new "#{Rails.root}/log/lograge.log"
    end

    def type_casted_binds(casted_binds)
      casted_binds.respond_to?(:call) ? casted_binds.call : casted_binds
    end

    def render_bind(attr, value)
      if attr.is_a?(Array)
        attr = attr.first
      elsif attr.type.binary? && attr.value
        value = "<#{attr.value_for_database.to_s.bytesize} bytes of binary data>"
      end

      [attr && attr.name, value]
    end
  end
end

# attach 到active_record上
SQLLog::LogSubscriber.attach_to :active_record
