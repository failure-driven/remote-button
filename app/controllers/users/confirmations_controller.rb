class Users::ConfirmationsController < Devise::ConfirmationsController # rubocop:disable Style/ClassAndModuleChildren
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super do |resource|
      sign_in resource
    end
  end
end
