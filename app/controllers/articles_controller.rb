class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :like, :destroy_like]

  def index

  end

  def new
    @article = Article.new(user_id: current_user.id)
  end

  def create
    @article = Article.new(permit_params)
    @article.user_id = current_user.id

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
      redirect_to(article_path(@article.id), notice: t('article.update_topic_success'))
    else
      render action: 'edit'
    end
  end

  def destroy

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