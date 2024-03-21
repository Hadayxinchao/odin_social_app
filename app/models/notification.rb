class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificationable, polymorphic: true
  validates :text, presence: true
end
