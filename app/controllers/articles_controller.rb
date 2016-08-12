class ArticlesController < ApplicationController

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
    @article = Article.find(params[:id])
    @comments = @article.comments

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def like
    @article = Article.find(params[:id])
    @article.liked_user_ids << current_user.id
    @article.likes_count = @article.liked_user_ids.length
    @article.save
    render plain: @article.likes_count
  end

  def destroy_like
    @article = Article.find(params[:id])
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

end