class NotificationsController < ApplicationController

  def index
    # binding.pry
    @notifications = current_user.notifications.order('created_at desc').page(params[:page]).per(20)
    # unread_ids = []
    # @notifications.each do |n|
    #   unread_ids << n.id unless n.read?
    # end
    @notification_groups = @notifications.group_by { |note| note.created_at.to_date }
    # Notification.read!(unread_ids)
    # Notification.realtime_push_to_client(current_user)
  end

  def clean
    Notification.where(user_id: current_user.id).delete_all
    redirect_to '/notifications/index'
  end

end