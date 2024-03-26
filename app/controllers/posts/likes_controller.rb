class Posts::LikesController < ApplicationController
  before_action :check_authorization, only: %i[index]

  def index
    @users = User.joins(:likes).where('likes.likeable_type = ? AND likes.likeable_id = ?', 'Post', params[:post_id])
    render 'likes/index'
  end

  private

  # Allow showing likes only of
  #   - comments that belong to posts whose author is the current_user or one of current_user's friends
  def check_authorization
    post_author = Post.find(params[:post_id]).author
    allow_create = false
    allowed_list = current_user.friends.to_a << current_user
    allow_create = true if allowed_list.include?(post_author)
    return if allow_create

    redirect_back_or_to root_path, status: :forbidden
  end
end
