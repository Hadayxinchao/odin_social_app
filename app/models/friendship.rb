class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :notifications, as: :notificationable, dependent: :destroy

  # Friendships statuses are:
  #   1: Friendship request sent, pending approval
  #   2: Friendship request approved
  # If friendship is declined by receiver or canceled by requester, delete Friendship entry
end
