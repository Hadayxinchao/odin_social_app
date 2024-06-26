class FriendshipsController < ApplicationController
  before_action :check_authorization, only: %i[update destroy]

  def index
    @user = User.find(params[:user_id])
    @name = if @user == current_user
              'My'
            else
              if @user.first_name.downcase[-1] != 's'
                "#{@user.first_name}'s"
              else
                "#{@user.first_name}'"
              end
            end
    friends_ids = Friendship.where(user_id: @user.id, status: 2).pluck(:friend_id)
    friends_ids.delete(current_user.id)
    if current_user == @user
      @friends = User.where(id: friends_ids).order(:first_name)
    else
      current_user_friends_ids = Friendship.where(user_id: current_user.id, status: 2).pluck(:friend_id)
      common_friends_ids = friends_ids.intersection(current_user_friends_ids)
      other_friends_ids = friends_ids.difference(common_friends_ids)
      @friends_in_common = User.where(id: common_friends_ids).order(:first_name)
      @other_friends = User.where(id: other_friends_ids).order(:first_name)
    end
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
    notification = create_notification(friendship)
    broadcast_notification(notification)
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
    notification = create_notification(friendship)
    broadcast_notification(notification)
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

  private

  # If frienship status == 1, create a notification for the receiver telling that
  # the requester has sent a friend request. Else, create a notification to requester
  # telling that the receiver has accepted the friend request.

  def create_notification(friendship)
    if friendship.status == 1
      Notification.create(user_id: friendship.requested.id,
                          notificationable_id: friendship.id,
                          notificationable_type: 'Friendship',
                          content: "#{friendship.requester.first_name} #{friendship.requester.last_name} has sent you a friend request",
                          path: user_path(friendship.requester))
    else
      Notification.create(user_id: friendship.requester.id,
                          notificationable_id: friendship.id,
                          notificationable_type: 'Friendship',
                          content: "#{friendship.requester.first_name} #{friendship.requester.last_name} has accepted your friend request",
                          path: user_path(friendship.requested))
    end
  end

  def check_authorization
    friendship = Friendship.find(params[:id])
    return if friendship.user_id == current_user.id

    flash[:error] = 'You are not authorized to perform this action'
    redirect_back_or_to root_path, status: :forbidden
  end
end
