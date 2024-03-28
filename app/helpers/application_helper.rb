module ApplicationHelper
  def field_is_blank?(field)
    if field.nil?
      true
    else
      [nil, ''].include?(field.strip)
    end
  end

  def unseen_notifications
    if current_user.notifications.empty?
      false
    else
      current_user.notifications_viewed_at.nil? ||
        current_user.notifications_viewed_at < current_user.notifications.last.created_at
    end
  end
end
