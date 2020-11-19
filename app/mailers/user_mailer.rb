class UserMailer < ApplicationMailer
  def button_registration
    @button = params[:button]
    mail(to: @button.email, subject: "Complete button registration")
  end
end
