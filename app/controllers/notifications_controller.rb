class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order('created_at desc').page(params[:page]).per(20)
    @notification_groups = @notifications.group_by { |note| note.created_at.to_date }
  end

  def clean
    Notification.where(user_id: current_user.id).delete_all
    redirect_to '/notifications/index'
  end

end