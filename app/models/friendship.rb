class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Friendships statuses are:
  #   1: Friendship request sent, pending approval
  #   2: Friendship request approved
  # If friendship is declined by receiver or canceled by requester, delete Friendship entry
end
