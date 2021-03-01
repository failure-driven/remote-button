class UserMailer < ApplicationMailer
  def button_registration
    @button = params[:button]
    mail(to: @button.email, subject: "Complete button registration")
  end

  def user_beta_invitation
    @user = params[:user]
    @token = params[:token]
    @reset_token = params[:reset_token]
    mail(to: @user.email, subject: "Beta invitation")
  end
end
