class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = Friendship.where(user_id: @user.id, status: 2).pluck(:friend_id)
    @friends = User.where(id: @friendships)
  end

  def create
    Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id], status: 1)
    Friendship.create(user_id: params[:friend_id], friend_id: params[:user_id], status: 2)
    @friend = User.find(params[:friend_id])
    redirect_to @friend
  end

  def update
  end

  def destroy
  end
end