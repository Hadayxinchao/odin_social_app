class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      unless current_user == comment.post.author  
        Notification.create(notificationable_id: comment.id,
                            notificationable_type: 'Comment',
                            user_id: comment.post.author.id,
                            content: "#{current_user.email} has commented on your post",
                            path: post_path(comment.post))
      end
      flash[:success] = 'Comment created'
    else
      flash[:error] = 'Invalid Comment'
    end
    redirect_back_or_to root_path
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back_or_to root_path
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
