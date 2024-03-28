module NotificationsHelper
  # returns the user who has triggered the notification
  def notification_triggerer(notification)
    n14e = notification.notificationable
    if n14e.instance_of?(Friendship)
      if n14e.status == 1
        n14e.requested
      else
        n14e.requester
      end
    elsif n14e.instance_of?(Like)
      n14e.user
    elsif n14e.instance_of?(Comment)
      n14e.author
    end
  end

  def recent_notifications
    n = current_user.notifications.where('created_at > ?', current_user.notifications_viewed_at).size
    if n > 5
      current_user.notifications.where('created_at > ?', current_user.notifications_viewed_at).order(created_at: :desc)
    else
      current_user.notifications.where(hidden: false).order(created_at: :desc).first(5)
    end
  end
end
