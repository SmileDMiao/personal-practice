class UsersController < ApplicationController

  def register
    @user = User.new()
    render layout: false
  end

  def create
    @user = User.new(permit_params)
    @user.avatar = @user.large_avatar_url
    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
      redirect_to :root
    else
      render :register,layout: false
    end
  end

  def login
    render layout: false
  end

  def sign_up
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      user.auth_token = user.generate_token
      user.save
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
      flash.notice = "登录成功！"
      redirect_to :root
    else
      flash.alert = "用户名密码错误！"
      redirect_to :login
    end
  end

  def logout
    cookies.delete(:auth_token)
    flash.notice = "退出登录！"
    redirect_to :root
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.avatar_name = params[:user][:avatar].try(:original_filename)
    respond_to do |format|
      if @user.update_attributes(permit_params)
        format.html { redirect_to @user, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #切换语言
  def language
    locale = params[:locale].to_s.strip.to_sym
    cookies[:locale] = locale
    if request.env['HTTP_REFERER'].present?
      redirect_to :back
    else
      redirect_to :root
    end
  end


  private
  def permit_params
    params.require(:user).permit!
  end

end

