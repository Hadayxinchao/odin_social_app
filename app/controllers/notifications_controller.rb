class NotificationsController < ApplicationController 
  before_action :check_authorization, only: %i[destroy]

  def index
  end

  def create
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_back_or_to root_path
  end

  private

  def check_authorization
    notification = Notification.find(params[:id])
    return if notification.user == current_user

    flash[:error] = 'You are not authorized to perform this action'
    redirect_back_or_to root_path, status: :forbidden
  end
end
