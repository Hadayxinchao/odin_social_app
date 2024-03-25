class CommentsController < ApplicationController
  before_action :check_authorization, only: %i[destroy]

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      unless current_user == comment.post.author
        Notification.create(notificationable_id: comment.id,
                            notificationable_type: 'Comment',
                            user_id: comment.post.author.id,
                            content: "#{current_user.first_name} #{current_user.last_name} has commented on your post",
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
    params.require(:comment).permit(:content, :post_id)
  end

  def check_authorization
    comment = Comment.find(params[:id])
    return if comment.author == current_user || comment.post.author == current_user

    flash[:error] = 'You are not authorized to delete this comment'
    redirect_back_or_to root_path, status: :forbidden
  end
end
