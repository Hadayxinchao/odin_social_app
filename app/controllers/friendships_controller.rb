class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = Friendship.where(user_id: @user.id, status: 2).pluck(:friend_id)
    @friends = User.where(id: @friendships)
  end

  def create
    Friendship.create(user_id: params[:user_id],
                      friend_id: params[:friend_id],
                      status: 1)
    Friendship.create(user_id: params[:friend_id],
                      friend_id: params[:user_id],
                      status: 1)
    @friend = User.find(params[:friend_id])
    redirect_to @friend
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship2 = Friendship.find_by(user_id: @friendship.friend_id,
                                      friend_id: @friendship.user_id)
    @friend = @friendship.friend
    @friendship.update(status: 2)
    @friendship2.update(status: 2)
    redirect_to @friend
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship2 = Friendship.find_by(user_id: @friendship.friend_id,
                                      friend_id: @friendship.user_id)
    @friend = @friendship.friend
    @friendship.destroy
    @friendship2.destroy
    redirect_to @friend
  end
end
