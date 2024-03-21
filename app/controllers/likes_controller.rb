class LikesController < ApplicationController
  def create
    like = Like.create(like_params)

    # Creates a notification for the user who created the post
    unless like.user_id == like.likeable.user_id
      Notification.create(notificationable_id: like.id,
                          notificationable_type: 'Like',
                          user_id: like.likeable.author.id,
                          content: "#{like.user.email} liked your post")
    end
    redirect_back_or_to root_path
  end

  def destroy
    Like.destroy(params[:id]) if current_user.id == Like.find(params[:id]).user_id
    redirect_back_or_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end
