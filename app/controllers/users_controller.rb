class UsersController < ApplicationController

  load_and_authorize_resource only: [:edit, :update, :destroy]
  before_action :set_user, except: [:register, :create, :login, :sign_up, :logout, :language]

  def register
    @user = User.new()
    render layout: false
  end

  def create
    @user = User.new(permit_params)
    @user.avatar = @user.large_avatar_url
    if @user.save
      UserMailer.delay.welcome_email(@user)
      cookies.permanent[:auth_token] = @user.auth_token
      redirect_to :root
    else
      render :register, layout: false
    end
  end

  def login
    if current_user
      redirect_to root_url
    else
      render layout: false
    end
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
      flash.alert = "用户名或密码错误！"
      redirect_to :login
    end
  end

  def logout
    cookies.delete(:auth_token)
    flash.notice = "退出登录！"
    redirect_to :root
  end

  def show
    # fresh_when([@user])
  end

  def edit
    if @user != current_user
      render_403
    end
  end

  def update
    @user.avatar_name = params[:user][:avatar].try(:original_filename)
    respond_to do |format|
      if @user.update_attributes(permit_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy

  end

  def change_password
    user = params[:user]
    if @user.authenticate(user[:password]) && user[:new_password] == user[:confirm_password]
      #更新密码操作
      @user.update(password_digest: BCrypt::Password.create(user[:new_password]))
      @user.save
      redirect_to @user, notice: 'User was successfully updated.'
    else
      @user.errors.add(:password, :invalid)
      render action: 'edit'
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

  #用户文章
  def articles
    @articles = @user.articles.time_desc.page(params[:page]).per(10)
    # fresh_when([@articles, @user])
  end

  def comments
    @comments = @user.comments.time_desc.page(params[:page]).per(10)
    # fresh_when([@comments, @user])
  end

  def favorites
    @article_ids = @user.favorite_article_ids
    @articles = Article.where(id: @article_ids).page(params[:page]).per(40)
    # fresh_when([@articles])
  end

  def following
    @users = @user.following.page(params[:page]).per(60)
    render template: '/users/followers'
  end

  def followers
    @users = @user.followers.page(params[:page]).per(60)
    # fresh_when([@users])
  end

  def follow
    current_user.follow_user(@user)
    render json: {code: 0, data: {followers_count: @user.follower_ids.length}}
  end

  def unfollow
    current_user.unfollow_user(@user)
    render json: {code: 0, data: {followers_count: @user.follower_ids.length}}
  end


  private
  def permit_params
    params.require(:user).permit!
  end

  def set_user
    @user = User.find_by_id(params[:id])

    if @user.blank?
      render_404
    end
  end

end

