class FriendshipsController < ApplicationController
  def index
    user = current_user
    friendships = Friendship.where(user_id: user.id, status: 2).pluck(:friend_id)
    @friends = User.where(id: friendships)
  end

  # When a friendship request is created:
  # 1. create friendship, with status 1
  # 2. create mirror friendship, with status 1
  # 3. create an appropiate notification
  # 4. redirect back to referer or to requested

  def create
    friend = User.find(params[:friend_id])
    friendship = current_user.create_friendship(friend)
    friendship.create_mirror_friendship
    friendship.create_notification
    redirect_back_or_to friendship.requested
  end

  # When a friendship request is accepted:
  # 1. update friendship status to 2
  # 2. update mirror friendship status to 2
  # 3. create an appropiate notification
  # 4. redirect back to referer or the requester

  def update
    friendship = Friendship.find(params[:id])
    friendship.update(status: 2)
    friendship.mirror_friendship.update(status: 2)
    friendship.create_notification
    redirect_back_or_to friendship.requester
  end

  # When a friendship is destroyed:
  # 1. retrieve friendship
  # 2. save other party of friendship to use on redirect path
  # 3. destroy mirror friendship
  # 4. destroy friendship
  # 5. redirect back to referer or to other party

  def destroy
    friendship = Friendship.find(params[:id])
    ex_friend = friendship.other_party(current_user)
    friendship.mirror_friendship.destroy
    friendship.destroy
    redirect_back_or_to ex_friend
  end
end
