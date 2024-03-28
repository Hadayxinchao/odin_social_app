module ApplicationHelper
  def field_is_blank?(field)
    if field.nil?
      true
    else
      [nil, ''].include?(field.strip)
    end
  end

  def unseen_notifications
    current_user.notifications_viewed_at.nil? ||
      (current_user.notifications.last && current_user.notifications_viewed_at < current_user.notifications.last.created_at)
  end
end
