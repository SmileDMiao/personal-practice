Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = ["ActionController::API", "ActionController::Base"]
  config.lograge.keep_original_rails_log = true
  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge.log"
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_payload do |controller|
    {
      trace_id: controller.request.uuid,
      host: controller.request.host,
      ip: controller.request.remote_ip,
      user_agent: controller.request.user_agent
    }
  end
  config.lograge.custom_options = lambda do |event|
    exceptions = %w[controller action format]
    {
      params: event.payload[:params].except(*exceptions),
      datetime: event.time.to_s,
      response: event.payload[:response],
      type: event.payload[:type]
    }
  end
end
