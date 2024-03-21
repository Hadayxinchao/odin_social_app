class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: @user.id)
  end

  def index
    @users = User.all
  end
end
