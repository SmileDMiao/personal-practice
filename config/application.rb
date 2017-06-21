require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PersonalPractice
  class Application < Rails::Application

    config.load_defaults 5.1

    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    config.filter_parameters += [:password, :confirm_password]

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

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

    # form_builder
    config.eager_load_paths << Rails.root.join('app', 'form_builders')

    # GraphQL
    config.autoload_paths << Rails.root.join('app/graphql')
    config.autoload_paths << Rails.root.join('app/graphql/types')

  end
end
