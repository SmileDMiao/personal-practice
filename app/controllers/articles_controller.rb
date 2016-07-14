class ArticlesController < ApplicationController

  def index

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permit_params)

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



  private
  #strong_parameters-详情查看github官方文档
  def permit_params
    #一开始我使用type而不是category，但是保存失败，type属于rails的关键字，请避免使用
    params.require(:article).permit!
  end

end