class HomeController < ApplicationController
  def index
    temp_password = SecureRandom.hex(8)

    @user = User.new(password: temp_password, password_confirmation: temp_password)
  end

  def old_index; end
end
