class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # helper_method声明一个controller的action为一个helper方法
  # check_login用户必须登录之后才可以访问系统,过滤调登录的两个action（避免在登录页面循环）
  # set_locale设置语言
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :check_login, except: [:login,:sign_up,:register,:create]
  before_action :set_locale

  def set_locale
    #另一种写法(ruby2.3) current_user&.language
    user_locale = cookies[:locale] || http_head_locale || current_user.try(:language).to_sym || I18n.default_locale
    I18n.locale = user_locale
  end

  def check_login
    unless current_user
      redirect_to({:controller => 'users', :action => 'login'})
    end
  end

  private

  #检测出用户浏览器中设置的语言偏好
  def http_head_locale
    http_accept_language.language_region_compatible_from(I18n.available_locales)
  end

  #获取当前用户的方法
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

end
