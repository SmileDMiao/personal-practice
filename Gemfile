source 'https://rubygems.org'
# source 'https://rubygems.org'

gem 'rails', '5.2.4.1'
gem 'pg', '~> 0.18'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'sdoc', group: :doc

# used for Rabbitmq
gem 'bunny'

# 浏览器语言偏好设置
gem 'http_accept_language'

# 表单
gem 'simple_form'
gem 'cocoon'

# 加密
gem 'bcrypt'

# 异常提醒
gem 'exception-track'

# markdown 代码高亮
gem 'redcarpet'
gem 'coderay'

# 上传组件
gem 'carrierwave'
gem 'mini_magick', '>= 4.9.4'

# 头像
gem 'letter_avatar'

# 验证
gem 'client_side_validations'

# 分享功能
gem 'social-share-button'

# 分页
gem 'kaminari'

# 缓存-Dalli
gem 'dalli'
gem 'redis'
gem 'redis-namespace'
gem 'hiredis'

# 搜索
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# 日志
gem 'lograge'

# influxdb
gem 'influxdb'

# 后台队列,sinatra web ui
gem 'sidekiq'
gem 'sinatra'
gem 'sidekiq-grouping'
gem 'sidekiq-scheduler'
gem 'sidekiq-status'
gem 'sidekiq-unique-jobs'

# Permission
gem 'pundit'

# Setting
gem 'rails-settings-cached'

# 图标
gem 'font-awesome-rails'
gem 'font-ionicons-rails'

# @功能
gem 'jquery-atwho-rails'

# 批量插入数据 批量插入/更新数据
gem 'bulk_insert'
gem 'upsert'

# Excel
gem 'spreadsheet'

# web server
gem 'puma'

# Pub/Sub
gem 'wisper'

# Graphql API
gem 'batch-loader'
gem 'graphql', '1.10.5'
gem 'graphql-preload'

# deploy
gem 'mina'
gem 'mina-sidekiq',:require => false

group :development, :test do
  # debug
  gem 'listen'
  gem 'byebug'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'pry-byebug'
	gem 'pry-doc'
  # 自动测试代码质量
  gem 'rubycritic'
  # 测试页面响应时间，sql查询时间
  gem 'rack-mini-profiler'
  # test framework rspec
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'

  gem 'rubocop-rspec'
  gem 'rails-perftest'
end

group :development do
  # 加速
  gem 'spring'
  gem 'spring-commands-rspec'
  # 友好的错误提示
  gem 'better_errors'
  # Graphql请求web页面
  gem 'graphiql-rails'
end
