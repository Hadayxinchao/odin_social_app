class UserMailer < ApplicationMailer
  default from: 'registration@odinsocial.com',
          reply_to: 'do_not_reply@odinsocial.com'

  def welcome_email
    @user = params[:user]
    @name = @user.first_name.capitalize
    mail(to: @user.email, subject: "#{@name}, welcome to My OdinSocial")
  end
end
