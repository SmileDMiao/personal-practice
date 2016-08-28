class NotifyCommentJob < ActiveJob::Base
  queue_as :notifications

  def perform(comment_id)
    Comment.notify_reply_created(comment_id)
  end
end
