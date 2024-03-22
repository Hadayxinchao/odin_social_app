class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :notifications, as: :notificationable, dependent: :destroy

  # Friendships statuses are:
  #   1: Friendship request sent, pending approval
  #   2: Friendship request approved
  # If friendship is declined by receiver or canceled by requester, delete Friendship entry

  def create_mirror_friendship
    requester_id = self.user_id
    requested_id = self.friend_id
    Friendship.create(user_id: requested_id, friend_id: requester_id, status: 1)
  end

  def mirror_friendship
    requester_id = self.user_id
    requested_id = self.friend_id
    Friendship.find_by(user_id: requested_id, friend_id: requester_id)
  end

  def requester
    self.original_friendship_request.user
  end

  def requested
    self.original_friendship_request.friend
  end

  def other_party(user)
    if user == self.requester
      self.requested
    else
      self.requester
    end
  end

  private

  def original_friendship_request
    if self.id < self.mirror_friendship.id
      self
    else
      self.mirror_friendship
    end
  end
end
