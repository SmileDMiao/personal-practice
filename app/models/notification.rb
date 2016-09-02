class Notification < ActiveRecord::Base


  scope :unread_count, ->(user) {where(:user_id => user.id)}

end