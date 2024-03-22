class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  append_before_action :require_name

  def require_name
    if current_user.present?
      redirect_to '/accounts/complete' if field_is_blank?(current_user.first_name) ||
                                          field_is_blank?(current_user.last_name)
    else
      true
    end
  end

  private

  def field_is_blank?(field)
    if field.nil?
      true
    else
      [nil, ''].include?(field.strip)
    end
  end
end
