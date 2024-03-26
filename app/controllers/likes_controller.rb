class LikesController < ApplicationController
  before_action :check_authorization_for_destroy, only: %i[destroy]
  before_action :check_authorization_for_create, only: %i[create]

  def create
    @like = Like.new(like_params)
    @like.user_id = current_user.id
    @like.save

    # Creates a notification unless like author is the post/comment author
    unless @like.user_id == @like.likeable.user_id
      path = if @like.likeable_type == 'Post'
               "#{post_path(@like.likeable.id)}"
             else
               "#{post_path(@like.likeable.post.id)}#comment_#{@like.likeable.id}"
             end
      notification = create_notification(@like, path)
      broadcast_notification(notification)
    end
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  private

  def notification_text(like)
    if like.likeable_type == 'Comment'
      "#{like.user.first_name} #{like.user.last_name} has liked your comment"
    elsif like.likeable_type == 'Post'
      "#{like.user.first_name} #{like.user.last_name} has liked your post"
    end
  end

  def create_notification(like, path)
    Notification.create(notificationable_id: like.id,
                        notificationable_type: 'Like',
                        user_id: like.likeable.author.id,
                        content: notification_text(like),
                        path: path)
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

  # Allow liking only:
  # - resources (comments or posts) whose author is the current_user or one of current_user's friends
  # - comments that belongs to posts whose author is the current_user or one of current_user's friends
  def check_authorization_for_create
    like = Like.new(like_params)
    resource = like.likeable
    allowed_list = current_user.friends.to_a << current_user

    allow_create = allowed_list.include?(resource.author) || (resource.is_a?(Comment) && allowed_list.include?(resource.post.author))

    redirect_back_or_to root_path, status: :forbidden unless allow_create
  end

  def check_authorization_for_destroy
    like = Like.find(params[:id])
    return if like.user_id == current_user.id

    redirect_back_or_to root_path, status: :forbidden
  end
end
