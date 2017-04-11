require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina_sidekiq/tasks'
require 'mina/unicorn'


# 基础设置:用户名,地址,路径,远程项目地址，分支
set :user, 'miao'
set :domain, '139.224.133.155'
set :deploy_to, '/home/miao/practice/personal-practice'
set :repository, 'https://github.com/SmileDMiao/personal-practice.git'
set :branch, 'master'
set :term_mode, nil

set :shared_paths, ['config/database.yml', 'log', 'tmp/pids']

set :sidekiq_pid, "#{deploy_to}/shared/tmp/pids/sidekiq.pid"

task :environment do
  invoke :'rvm:use[2.3.0]'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids/"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/pids/")
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/log/")
end

desc 'Deploys the current version to the server.'
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'unicorn:restart'
      invoke :'sidekiq:quiet'
      invoke :'sidekiq:restart'
    end
  end
end

desc 'restart unicorn'
task :restart => :environment do
  invoke :'unicorn:restart'
end