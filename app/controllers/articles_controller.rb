class ArticlesController < ApplicationController

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy, :show, :favorite]
  before_action :set_article, only: [:show, :edit, :update, :like, :destroy_like]

  def index
    @articles = Article.page(params[:page]).per(20).order(created_at: :desc)
  end

  def new
    @article = Article.new(user_id: current_user.id)
  end

  def create
    @article = Article.new(permit_params)
    @article.user_id = current_user.id

    full_name = @article.body.scan(/@([A-Za-z0-9\-\_\.]{3,20})/).flatten.map(&:downcase)
    if full_name.any?
      @article.mentioned_user_ids = User.where('lower(full_name) IN (?) AND id != (?)', full_name, @article.user_id).limit(5).pluck(:id)
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Product was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comments = @article.comments

    check_current_user_status_for_article

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def edit

  end

  def update
    @article.update_attributes(permit_params)
    if @article.save
      redirect_to(article_path(@article.id), notice: '更新文章成功')
    else
      render action: 'edit'
    end
  end

  def destroy

  end

  %w(no_comment popular).each do |name|
    define_method(name) do
      @articles = Article.send(name.to_sym).includes(:user)
      @articles = @articles.page(params[:page]).per(20)

      render action: 'index'
    end
  end

  def like
    @article.liked_user_ids << current_user.id
    @article.likes_count = @article.liked_user_ids.length
    @article.save
    render plain: @article.likes_count
  end

  def destroy_like
    @article.liked_user_ids.delete(current_user.id)
    @article.likes_count = @article.liked_user_ids.length
    @article.save
    render plain: @article.likes_count
  end

  def favorite
    current_user.favorite_article(params[:id])
    render plain: '1'
  end

  def destroy_favorite
    current_user.unfavorite_article(params[:id])
    render plain: '1'
  end

  def node
    @node = Node.find(params[:id])
    @articles = @node.articles
    @articles = @articles.includes(:user).page(params[:page]).per(25).order(created_at: :desc)
    render action: 'index'
  end


  private
  def permit_params
    params.require(:article).permit!
  end

  def set_article
    @article ||= Article.find(params[:id])
  end

  def check_current_user_status_for_article
    return false unless current_user
    # 通知处理
    current_user.read_article(@article, comment_ids: @comments.collect(&:id))
  end

end