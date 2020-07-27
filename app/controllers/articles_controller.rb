# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update like destroy_like destroy]

  def index
    @articles = Article.time_desc.includes(:user, :node).page(params[:page])
  end

  def new
    @article = Article.new(user_id: current_user.id)
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    full_name = @article.body.scan(/@([A-Za-z0-9\-\_\.]{3,20})/).flatten.map(&:downcase)
    if full_name.any?
      @article.mentioned_user_ids = User.where("lower(full_name) IN (?) AND id != (?)", full_name, @article.user_id).limit(5).pluck(:id)
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @comments = @article.comments

    check_current_user_status_for_article

    fresh_when([@comments, @article])
  end

  def edit; end

  def update
    authorize @article

    @article.update_attributes(article_params)
    if @article.save
      redirect_to(article_path(@article.id), notice: "更新文章成功")
    else
      render action: "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to(articles_path, notice: "文章成功删除")
  end

  %w[no_comment popular].each do |name|
    define_method(name) do
      @articles = Article.send(name.to_sym).includes(:user)
      @articles = @articles.page(params[:page])

      render action: "index"
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
    render plain: "1"
  end

  def destroy_favorite
    current_user.unfavorite_article(params[:id])
    render plain: "1"
  end

  def node
    @node = Node.find(params[:id])
    @articles = @node.articles
    @articles = @articles.includes(:user).time_desc.page(params[:page])
    render action: "index"
  end

  private

    def article_params
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
