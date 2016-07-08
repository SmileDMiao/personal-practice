class UsersController < ApplicationController

  def register
    @user = User.new()
    render layout: false
  end

  def create
    @user = User.new(permit_params)
    if @user.save
      redirect_to :root
    else
      render :register,layout: false
    end
  end

  def login
    render layout: false
  end

  def sign_up
    binding.pry
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # if params[:remember_me]
      #   cookies.permanent[:auth_token] = user.auth_token
      # else
      #   cookies[:auth_token] = user.auth_token
      # end
      flash.notice = "登录成功！"
      redirect_to :root
    else
      flash.notice = "用户名密码错误！"
      redirect_to :login
    end

  end

  private
  def permit_params
    params.require(:user).permit!
  end

end

