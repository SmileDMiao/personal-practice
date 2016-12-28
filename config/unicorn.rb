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
#listen 8080, :tcp_nopush => true

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


# before_fork do |server, worker|
#   old_pid = "/path_to_app/shared/pids/unicorn.pid.oldbin"
#   if File.exists?(old_pid) && server.pid != old_pid
#     begin
#       Process.kill("QUIT", File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH
#       puts "Send 'QUIT' signal to unicorn error!"
#     end
#   end
# end
#
# after_fork do |server, worker|
#   # per-process listener ports for debugging/admin/migrations
#   # addr = "127.0.0.1:#{9293 + worker.nr}"
#   # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)
#
#   # the following is *required* for Rails + "preload_app true",
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.establish_connection
#
#   # if preload_app is true, then you may also want to check and
#   # restart any other shared sockets/descriptors such as Memcached,
#   # and Redis.  TokyoCabinet file handles are safe to reuse
#   # between any number of forked children (assuming your kernel
#   # correctly implements pread()/pwrite() system calls)
# end
