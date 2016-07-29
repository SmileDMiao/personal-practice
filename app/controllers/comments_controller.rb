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


  private
  def permit_params
    params.require(:comment).permit!
  end

end