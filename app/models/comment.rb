class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :article

  validates_presence_of :body

  def liked_by_user?(user)
    return false if user.blank?
    liked_user_ids.include?(user.id)
  end

  after_commit :create_reply_notify, on: :create
  def create_reply_notify
    NotifyCommentJob.perform_later(id)
  end

  def self.notify_reply_created(comment_id)
    comment = Comment.find_by_id(comment_id)
    return if comment.blank?
    article = Article.find_by_id(comment.article_id)
    return if article.blank?

    notified_user_ids = comment.mentioned_user_ids

    # 给发帖人发回帖通知
    if comment.user_id != article.user_id && !notified_user_ids.include?(article.user_id)
      Notification.create notify_type: 'article_comment',
                          actor_id: comment.user_id,
                          user_id: article.user_id,
                          target_id: comment.id,
                          target_type: 'COMMENT',
                          second_target_type: 'ARTICLE',
                          second_target_id: article.id
      notified_user_ids << article.user_id
    end

    follower_ids = comment.user.try(:follower_ids) || []
    follower_ids.uniq!

    # 给关注者发通知
    default_note = {
        notify_type: 'article_comment',
        target_type: 'Comment', target_id: comment.id,
        second_target_type: 'Article', second_target_id: article.id,
        actor_id: comment.user_id
    }
    Notification.bulk_insert do |worker|
      follower_ids.each do |uid|
        # 排除同一个回复过程中已经提醒过的人
        next if notified_user_ids.include?(uid)
        # 排除回帖人
        next if uid == comment.user_id
        logger.debug "Post Notification to: #{uid}"
        note = default_note.merge(user_id: uid)
        worker.add(note)
      end
    end

    true
  end

end