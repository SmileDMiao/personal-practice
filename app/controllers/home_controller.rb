class HomeController < ApplicationController

  def index
    @articles = Article.popular.page(params[:page]).per(10)
  end

end