# frozen_string_literal: true

module Admin
  class ArticlesController < Admin::ApplicationController
    def index
      @articles = Article.page(params[:page])
    end

    def new
      @article = Article.new
    end

    def create
      permit_params
      @article = Article.new(permit_params)
      @article.user_id = current_user.id
      @article.comments.map { |m| m.user_id = current_user.id }
      if @article.save
        redirect_to admin_articles_path, notice: "article was successfully created."
      else
        render :new_admin_article
      end
    end

    def update
    end


    private

      def permit_params
        params.require(:article).permit(:node_id, :title, :body, comments_attributes: [:user_id, :body, :_destroy])
      end
  end
end
