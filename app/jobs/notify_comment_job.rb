class NotifyCommentJob < ActiveJob::Base
  queue_as :default

  def perform(comment_id)
    Comment.notify_comment_created(comment_id)
  end
end
