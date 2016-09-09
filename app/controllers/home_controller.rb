class HomeController < ApplicationController

  def index
    @articles = Article.popular.includes(:user,:node).page(params[:page]).per(10)
    fresh_when(@articles)
  end

end