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
end
