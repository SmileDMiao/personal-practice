module Admin
  class PracticesController < Admin::ApplicationController

    def soulmate

    end

    def bootstrap_table
      @num = Food.count
      @food = Food.select(:id, :name, :category, :number).offset(params[:offset]).limit(params[:limit])
      respond_to do |format|
        format.html
        format.json { render :json => {total: @num, rows: @food} }
      end
    end

    def get_data
      @num = Food.count
      @food = Food.select(:id, :name, :category, :number).offset(params[:offset]).limit(params[:limit])
      @food = @food.where(:name => params[:search]) if params[:search]
      respond_to do |format|
        format.json { render :json => {total: @num, rows: @food} }
      end
    end

  end
end