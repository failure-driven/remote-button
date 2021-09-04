class HomeController < ApplicationController
  def index
    temp_password = SecureRandom.hex(8)

    @user = User.new(password: temp_password, password_confirmation: temp_password)
  end

  def old_index
  end

  # TODO: move to own controller or check if flipper provides this already?
  def enable_flip
    begin
      unless signed_in?
        user = User.with_reset_password_token(params[:reset_token])
        sign_in user
      end
      jwt_payload = JWT.decode(params[:token], Rails.application.secrets.secret_key_base).first
      current_user_id = jwt_payload["id"]
      # TODO: the feature flip should be passed in the jwt payload
      Flipper[:beta_button].enable current_user if current_user && current_user.id == current_user_id
      flash[:success] = "Congratulations you are now part of the Button Beta."
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      # head :unauthorized
    end
    redirect_to root_path
  end

  # TODO: move to own controller or check if flipper provides this already?
  def disable_flip
    # TODO: force a login
    begin
      jwt_payload = JWT.decode(params[:token], Rails.application.secrets.secret_key_base).first
      current_user_id = jwt_payload["id"]
      Flipper[:beta_button].disable current_user if current_user && current_user.id == current_user_id
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      # head :unauthorized
    end
    redirect_to root_path
  end
end
