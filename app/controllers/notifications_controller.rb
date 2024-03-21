class NotificationsController < ApplicationController
  def index
  end

  def create
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_back_or_to root_path
  end
end
