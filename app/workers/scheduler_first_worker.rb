class SchedulerFirstWorker

  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options :queue => :scheduler, :retry => false, :backtrace => true

  def perform
    puts 'Server 1: Hello Sidekiq Scheduler'
  end

end
