class LikesController < ApplicationController
  def create
    Like.create(like_params)
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
