class CommentsController < ApplicationController
  before_action :check_authorization_for_destroy, only: %i[destroy]
  before_action :check_authorization_for_other_actions, except: %i[destroy]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        unless current_user == @comment.post.author
          Notification.create(notificationable_id: @comment.id,
                              notificationable_type: 'Comment',
                              user_id: @comment.post.author.id,
                              content: "#{current_user.first_name} #{current_user.last_name} has commented on your post",
                              path: post_path(@comment.post))
        end
        format.turbo_stream
        format.html { redirect_back_or_to post_comments_path(@comment.post) }
      else
        flash[:error] = 'Invalid Comment'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def check_authorization_for_other_actions
    post = Post.find(params[:post_id])
    return if post.author == current_user || post.author.friends.exists?(id: current_user.id)

    redirect_back_or_to root_path, status: :forbidden
  end

  def check_authorization_for_destroy
    comment = Comment.find(params[:id])
    return if comment.author == current_user || comment.post.author == current_user

    flash[:error] = 'You are not authorized to delete this comment'
    redirect_back_or_to root_path, status: :forbidden
  end
end
