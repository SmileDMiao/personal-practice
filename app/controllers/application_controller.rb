class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # helper_method声明一个controller的action为一个helper方法
  # set_locale设置语言
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :unread_notify_count

  etag { flash }

  before_action :set_locale

  def check_login
    unless current_user
      redirect_to({:controller => 'users', :action => 'login'})
    end
  end

  def set_locale
    #另一种写法 current_user&.language
    user_locale = cookies[:locale] || http_head_locale || current_user.try(:language).to_sym || I18n.default_locale
    I18n.locale = user_locale
  end

  def render_404
    render_optional_error_file(404)
  end

  def render_403
    render_optional_error_file(403)
  end

  #cancancan权限过滤
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: '访问被拒绝，你可能没有权限.'
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    fname = %w(404 403 422 500).include?(status) ? status : 'unknown'
    render template: "/errors/#{fname}", format: [:html],
           handler: [:erb], status: status, layout: 'application'
  end

  def unread_notify_count
    return 0 if current_user.blank?
    @unread_notify_count ||= Notification.unread_count(current_user).count
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
