class CommentsController < ApplicationController

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

  def like
    @comment = Comment.find(params[:id])
    @comment.liked_user_ids << current_user.id
    @comment.likes_count = @comment.liked_user_ids.length
    @comment.save
    render plain: @comment.likes_count
  end

  def destroy_like
    @comment = Comment.find(params[:id])
    @comment.liked_user_ids.delete(current_user.id)
    @comment.likes_count = @comment.liked_user_ids.length
    @comment.save
    render plain: @comment.likes_count
  end


  private
  def permit_params
    params.require(:comment).permit!
  end

end