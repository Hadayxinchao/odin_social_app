class PostsController < ApplicationController
  before_action :check_authorization_for_destroy, only: %i[destroy]
  before_action :check_authorization_for_show, only: %i[show]
  def index
    friends_ids = Friendship.where(user_id: current_user.id, status: 2).pluck(:friend_id)
    @post = Post.new
    @posts = Post.where(user_id: current_user.id)
                 .or(Post.where(user_id: friends_ids))
                 .order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.turbo_stream
        format.html { redirect_back_or_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    path = post_url(@post)
    @post.destroy
    respond_to do |format|
      format.turbo_stream
      if request.referer == path
        format.html { redirect_to root_path }
      else
        format.html { redirect_back_or_to root_path }
      end
    end
  
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def check_authorization_for_destroy
    post = Post.find(params[:id])
    return if post.author == current_user

    flash[:error] = 'You are not authorized to delete this post'
    redirect_back_or_to root_path, status: :forbidden
  end

  def check_authorization_for_show
    post = Post.find(params[:id])
    return if post.author == current_user || post.author.friends.exists?(id: current_user.id)

    redirect_back_or_to root_path, status: :forbidden
  end
end
