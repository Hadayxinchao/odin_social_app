class LandingsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_name

  def home
    redirect_to posts_path if user_signed_in?
  end
end
