class CommonWorker

  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options :queue => :default, :retry => false, :backtrace => true

  def perform(number)
    puts "================server1================"
    sleep 5
    puts "================worker#{number}================"
  end

end