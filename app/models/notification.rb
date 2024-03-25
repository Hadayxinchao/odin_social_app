class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificationable, polymorphic: true
  validates :content, presence: true

  after_create :broadcast_notification

  private

  def broadcast_notification
    NotificationsChannel.broadcast_to(User.find(self.user_id), self)
  end
end
