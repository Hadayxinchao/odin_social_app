# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_name
  after_action :set_avatar, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # GET /resource/complete
  def complete_edit
    @user = User.find(current_user.id)
    @first_name = strip_or_nil(@user, 'first_name')
    @last_name = strip_or_nil(@user, 'last_name')
    render :complete_edit
  end

  # POST /resource/complete
  def complete_update
    @user = User.find(current_user.id)
    @user.update(complete_params)
    if [nil, ''].include?(params[:user][:first_name].strip) || [nil, ''].include?(params[:user][:last_name].strip)
      if [nil, ''].include?(params[:user][:first_name].strip)
        @user.errors.add(:first_name, "can't be blank")
      end
      if [nil, ''].include?(params[:user][:last_name].strip)
        @user.errors.add(:last_name, "can't be blank")
      end
      render 'devise/registrations/complete_edit', status: :unprocessable_entity and return
    end
    redirect_to :root
  end

  # PUT /resource
  def update
    @user = User.find(current_user.id)
    @user.errors.add(:first_name, "can't be blank") if [nil, ''].include?(params[:user][:first_name].strip)
    @user.errors.add(:last_name, "can't be blank") if [nil, ''].include?(params[:user][:last_name].strip)
    @user.errors.add(:current_password, "can't be blank") if [''].include?(params[:user][:current_password])

    if [nil, ''].include?(params[:user][:first_name].strip) || [nil, ''].include?(params[:user][:last_name].strip)
      render 'devise/registrations/edit', status: :unprocessable_entity and return
    end
    if params[:user][:avatar] && params[:user][:current_password] == ''
      @user.errors.add(:current_password, "can't be blank")
      render 'devise/registrations/edit', status: :unprocessable_entity and return
    end
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name current_password avatar])
  end

  def complete_params
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end

  def set_avatar
    if current_user
      user = current_user
      avatar_url = URI.parse("https://gravatar.com/avatar/#{Digest::SHA256.hexdigest(user.email)}")
      filename = File.basename(avatar_url.path)
      avatar_file = avatar_url.open
      user.avatar.attach(io: avatar_file, filename: filename)
    end
    return unless current_user
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
