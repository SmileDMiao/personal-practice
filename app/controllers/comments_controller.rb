class CommentsController < ApplicationController

  before_action :set_article, only: [:edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy, :like, :destroy_like]

  def create
    @comment = Comment.new(permit_params)
    @comment.article_id = params[:article_id]
    @comment.user_id = current_user.id

    if @comment.save
      @msg = t('topics.reply_success')
    else
      @msg = @comment.errors.full_messages.join('<br />')
    end
  end

  def edit

  end

  def update
    if @comment.update_attributes(permit_params)
      redirect_to(article_path(@comment.article_id), notice: '回帖更新成功。')
    else
      render action: 'edit'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to(article_path(@comment.article_id), notice: '回帖删除成功。')
    else
      redirect_to(article_path(@comment.article_id), alert: '程序异常，删除失败。')
    end
  end

  def like
    @comment.liked_user_ids << current_user.id
    @comment.likes_count = @comment.liked_user_ids.length
    @comment.save
    render plain: @comment.likes_count
  end

  def destroy_like
    @comment.liked_user_ids.delete(current_user.id)
    @comment.likes_count = @comment.liked_user_ids.length
    @comment.save
    render plain: @comment.likes_count
  end


  private
  def permit_params
    params.require(:comment).permit!
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end