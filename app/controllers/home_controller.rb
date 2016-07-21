class HomeController < ApplicationController

  def index
    @articles = Article.page(params[:page]).per(10).order(:created_at)
  end

end