class Notification < ApplicationRecord

  scope :unread_count, ->(user) { where(:user_id => user.id) }

  def self.notify_follow(user_id, follower_id)
    opts = {
        notify_type: 'follow',
        user_id: user_id,
        actor_id: follower_id
    }
    return if Notification.where(opts).count > 0
    Notification.bulk_insert do |worker|
      worker.add(opts)
    end
    # Notification.create opts
  end

end