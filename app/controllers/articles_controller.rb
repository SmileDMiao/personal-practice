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


  private
  def permit_params
    params.require(:article).permit!
  end

end