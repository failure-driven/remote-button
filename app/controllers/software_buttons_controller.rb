class SoftwareButtonsController < ApplicationController
  def new
    @button = Button.new
  end

  def create
    # check parameters are good
    # if not tell user
    # if yes make call to site Net hTTp register button at site
    # if result is success - tell user
    # if result is failure - tell user
    redirect_to new_software_button_path, alert: "Creating button is currently not implemented"
  end
end
