class FoodsController < ApplicationController

  def index
    @foods = Food.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  def new_simple
    @food = Food.new()
  end

  def new
    @food = Food.new()
  end

  def create
    @food = Food.new(post_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Product was successfully created.' }
        format.json { render json: @food, status: :created, location: @food }
      else
        format.html { render action: "new" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @food = Food.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def post_params
    #一开始我使用type而不是category，但是保存失败，type属于rails的关键字，请避免使用
    params.require(:food).permit(:name,:color,:number,:category,:odor,:price,:rate_flag,:description)
  end

end