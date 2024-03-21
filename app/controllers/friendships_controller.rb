class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = Friendship.where(user_id: @user.id, status: 2).pluck(:friend_id)
    @friends = User.where(id: @friendships)
  end

  def create
    user = current_user
    friend = User.find(params[:friend_id])
    friendship = Friendship.create(user_id: user.id, friend_id: friend.id, status: 1)
    Friendship.create(user_id: friend.id, friend_id: user.id, status: 1)
    Notification.create(user_id: friend.id,
                        notificationable_id: friendship.id,
                        notificationable_type: 'Friendship',
                        content: "#{user.email} has sent you a friend request")
    redirect_to friend
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
