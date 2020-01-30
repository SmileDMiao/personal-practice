class ChatsController < ApplicationController

  before_action :check_login

  def index
    @users = User.all.where.not(id: current_user.id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @messages = Message.where(send_user_id: @user.id, receive_user_id: current_user.id).
        or(Message.where(send_user_id: current_user.id, receive_user_id: @user.id)).order(created_at: :ASC)
  end


end
