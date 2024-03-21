class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friendship1 = Friendship.find_by user_id: current_user.id, friend_id: @user.id
    @friendship2 = Friendship.find_by user_id: @user.id, friend_id: current_user.id

    # Checks if friendship request exists
    if @friendship1
      # Tells the role of current_user on the Friendship request
      @role = if @friendship2.id > @friendship1.id
                'requester'
              else
                'requested'
              end
    end
  end

  def index
    @users = User.all
  end
end
