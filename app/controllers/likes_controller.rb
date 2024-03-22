class LikesController < ApplicationController
  def create
    like = Like.create(like_params)

    # Creates a notification unless like author is the post/comment author
    unless like.user_id == like.likeable.user_id
      path = if like.likeable_type == 'Post'
               post_path(like.likeable)
             else
               post_path(like.likeable.post)
             end
      Notification.create(notificationable_id: like.id,
                          notificationable_type: 'Like',
                          user_id: like.likeable.author.id,
                          content: notification_text(like),
                          path: path)
    end
    redirect_back_or_to root_path
  end

  def destroy
    Like.destroy(params[:id]) if current_user.id == Like.find(params[:id]).user_id
    redirect_back_or_to root_path
  end

  private

  def notification_text(like)
    if like.likeable_type == 'Comment'
      "#{like.user.email} has liked your comment"
    elsif like.likeable_type == 'Post'
      "#{like.user.email} has liked your post"
    end
  end

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end
