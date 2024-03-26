class NotificationsController < ApplicationController
  before_action :check_authorization, except: %i[index]

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def update_hidden
    @notification = Notification.find(params[:id])
    @notification.update(hidden: true)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  private

  def check_authorization
    notification = Notification.find(params[:id])
    return if notification.user_id == current_user.id

    flash[:error] = 'You are not authorized to perform this action'
    redirect_back_or_to root_path, status: :forbidden
  end
end
