class FoodsController < ApplicationController

  def index
    #params[:page]分页参数(可定制),10records per page
    @foods = Food.page(params[:page]).per(10)
    @foods = Food.where(:name => params[:table_search]).page(params[:page]).per(10) if params[:table_search]
    respond_to do |format|
      format.html # index.html.erb
      format.js
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
    @food = Food.new(permit_params)

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
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])

    respond_to do |format|
      if @food.update_attributes(permit_params)
        format.html { redirect_to foods_url, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :ok }
    end
  end


  private
  #strong_parameters-详情查看github官方文档
  def permit_params
    #一开始我使用type而不是category，但是保存失败，type属于rails的关键字，请避免使用
    params.require(:food).permit!
  end

end