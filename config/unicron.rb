# unicorn 配置信息

app_dir = File.expand_path("../..", __FILE__)

# unmber of processes
worker_processes 4

# timeout of worker process (s)
timeout 30

# 监听本地socket,tcp端口
# 监听tcp端口可以直接访问该端口，也可以不监听tcp端口
# backlog: number of clients,default 1024
# tcp_nopush: Default: false This defaulted to true in unicorn 3.4 - 3.7,大概是减少延迟,提高性能的作用
listen "/tmp/unicorn_blog.sock", :backlog => 64
# listen 3000, :tcp_nopush => true

# before forking work process 预加载
preload_app true

# default false,在调用application之前检查client connection.
# 大概意思是在本地访问，能检查到连接是否断开,要是远程client,设置为true也未必能检查到.
check_client_connection false

# app directory
working_directory app_dir

pid "#{app_dir}/tmp/pids/unicorn.pid"

# unicorn error log
stderr_path "#{app_dir}/log/unicorn.stderr.log"


# unicorn outut log
stdout_path "#{app_dir}/log/unicorn.stdout.log"