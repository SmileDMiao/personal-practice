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


set :shared_paths, ['config/database.yml', 'log']

task :environment do
  invoke :'rvm:use[2.3.0]'
end

task :setup => :environment do

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
      invoke :'sidekiq:restart'
    end
  end
end

desc 'start unicorn'
task :start => :environment do
  invoke :'unicorn:start'
end

desc 'stop unicorn'
task :start => :environment do
  invoke :'unicorn:stop'
end

desc 'restart unicorn'
task :start => :environment do
  invoke :'unicorn:restart'
end