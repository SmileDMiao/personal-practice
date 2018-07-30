class NotifyCommentWorker

  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options :queue => :notifications, :retry => false, :backtrace => true

  def perform(comment_id)
    Comment.notify_comment_created(comment_id)
  end

end
