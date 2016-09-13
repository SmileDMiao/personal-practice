require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PersonalPractice
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    #后台任务adapter:sidekiq(还是用sidekiq的写法好，支持特性多，不易出现问题)
    config.active_job.queue_adapter = :sidekiq

    #文件缓存
    $file_store = ActiveSupport::Cache::FileStore.new(Rails.root.join('tmp/cache'))

    #异常提醒
    config.eager_load_paths.push(*%W(#{config.root}/lib/exception_notification))

    #使用内存缓存
    # config.cache_store = :memory_store

    #使用文件缓存
    # config.cache_store = :file_store, Rails.root.join('tmp')

    #使用memcached缓存服务器
    #namespace:缓存命名空间，expires_in:换粗 过期时间,compress:缓存过大时是否压缩,l_size:dalli connection pool
    config.cache_store = [:mem_cache_store, '127.0.0.1', { :namespace => 'malzahar', :compress => true }]
  end
end
