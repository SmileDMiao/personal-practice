class ChatsController < ApplicationController

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @messages = Message.where(send_user_id: @user.id, receive_user_id: current_user.id).
        or(Message.where(send_user_id: current_user.id, receive_user_id: @user.id)).order(created_at: :ASC)
  end


end
