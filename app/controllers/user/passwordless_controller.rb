class User::PasswordlessController < Devise::PasswordsController # rubocop:disable Style/ClassAndModuleChildren
  def confirmation
    user = User.confirm_by_token(params[:confirmation_token])
    if user.present?
      sign_in user
      redirect_to root_path, notice: "Your email address has been successfully confirmed."
    else
      redirect_to root_path, notice: "Please sign up again, the confirmation link was not valid."
    end
  end
end
