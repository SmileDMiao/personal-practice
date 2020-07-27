# frozen_string_literal: true

$influxdb = InfluxDB::Client.new("blog", hosts: ["127.0.0.1"], port: 8086, username: "root", password: "root")

# 关注 ActionController 的 process_action 通知，会收到所有的请求
# ActiveSupport::Notifications.subscribe('process_action.action_controller') do |*args|
#   event = ActiveSupport::Notifications::Event.new(*args)

#   info = {
#     values: {
#       action: "#{event.payload[:controller]}##{event.payload[:action]}",
#       runtime: event.duration,
#       db_runtime: event.payload[:db_runtime],
#       server: Socket.gethostname,
#       status: event.payload[:status]
#     }
#   }

#   $influxdb.write_point("rails_log", info)
# end
