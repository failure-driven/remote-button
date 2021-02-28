class UsersController < Devise::PasswordsController
  def auth
    user = User.where("id =? and reset_password_token =?", params[:format], params[:reset_password_token]).first
    binding.pry
    if user.present?
      user.reset_password_token = nil
      user.save
      sign_in user
      redirect_to root_path, notice: "success??"#Login path
    else
      redirect_to root_path, notice: "no user??"
    end
  end
end
