class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  append_before_action :require_name

  def require_name
    first_name = strip_or_nil(current_user, 'first_name')
    last_name = strip_or_nil(current_user, 'last_name')

    redirect_to '/accounts/complete' if [nil, ''].include?(first_name) ||
                                        [nil, ''].include?(last_name)
  end

  def strip_or_nil(user, property)
    user&.send(property)&.strip
  end

  def broadcast_notification(notification)
    NotificationsChannel.broadcast_to(User.find(notification.user_id), notification)
  end
end
