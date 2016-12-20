# unicorn 配置信息

# unmber of processes
worker_processes 4

# timeout of worker process (s)
timeout 30

listen "/tmp/unicorn_blog.sock", :backlog => 64
listen 8080, :tcp_nopush => true

# before forking work process 预加载
preload_app true

check_client_connection false

# app directory
working_directory "/home/miao/hand/source/personal/personal-practice"

pid "/home/miao/hand/source/personal/personal-practice/tmp/pids/unicorn.pid"

# unicorn error log
stderr_path "/home/miao/hand/source/personal/personal-practice/log/unicorn.stderr.log"


# unicorn outut log
stdout_path "/home/miao/hand/source/personal/personal-practice/log/unicorn.stdout.log"


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