class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'Comment created'
    else
      flash[:error] = 'Invalid Comment'
    end
    redirect_back_or_to root_path
  end

  def destroy
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
