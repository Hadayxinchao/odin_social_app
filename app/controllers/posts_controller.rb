class PostsController < ApplicationController
  def index
    friends_ids = Friendship.where(user_id: current_user.id, status: 2).pluck(:friend_id)
    @post = Post.new()
    @posts = Post.where(user_id: current_user.id)
                 .or(Post.where(user_id: friends_ids))
                 .order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_back_or_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    path = post_url(@post)
    @post.destroy
    if request.referer == path
      redirect_to root_path
    else
      redirect_back_or_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
