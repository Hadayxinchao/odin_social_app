class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = Friendship.where(user_id: @user.id, status: 2).pluck(:friend_id)
    @friends = User.where(id: @friendships)
  end

  def create
  end

  def update
  end

  def destroy
  end
end
