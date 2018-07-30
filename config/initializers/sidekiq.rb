# Config Sidekiq
# Set Sidekiq-Scheduler From a Separate File
# Config Sidekiq-Status
#
# Server-side middleware runs 'around' job processing.
# Client-side middleware runs before the pushing of the job to Redis and allows you to modify/stop the job before it gets pushed.

Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'personal_practice', url: 'redis://localhost:6379/6' }

  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq-scheduler.yml', __FILE__))
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end

  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'personal_practice', url: 'redis://localhost:6379/6' }

  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end