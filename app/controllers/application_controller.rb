class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #用户必须登录之后才可以访问系统,过滤调登录的两个action（避免在登录页面循环）
  #用 before_filter 怎么实现?
  before_action :check_login, except: [:login,:sign_up]

  def check_login
    unless current_user
      redirect_to({:controller => 'users', :action => 'login'})
    end
  end

  private

  #获取当前用户的方法
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  helper_method :current_user

end
