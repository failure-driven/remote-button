
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
    @response = Net::HTTP.post_form(
      URI(software_button_params[:site]),
      { "button[email]" => params[:button][:email],
      "button[site]" => params[:button][:site],
      "button[external_reference]" => params[:button][:external_reference], },
      )
      JSON.parse(@response.body)
    # require 'pry'
    # binding.pry
    
    json = JSON.parse(@response.body)
    redirect_to json["button_url"]
  end

  private

  def software_button_params
    params.require(:button).permit(:email, :site, :external_reference)
  end
end
