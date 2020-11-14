class SoftwareButtonsController < ApplicationController
  def new
    @button = Button.new
  end

  def create
    (response, json_response) = post_create_button

    if response.is_a? Net::HTTPSuccess
      flash[:success] = "Software button successfully created."
      redirect_to json_response["button_url"]
    else
      redirect_to new_software_button_path, alert: json_response["error"]
    end
  rescue ArgumentError => e
    redirect_to new_software_button_path, alert: e.message
  end

  private

  def software_button_params
    return unless params[:button]

    params.require(:button).permit(:email, :site, :ssid, :password)
  end

  def post_create_button
    response = Net::HTTP.post_form(
      URI(software_button_params[:site]),
      {
        "button[email]" => software_button_params[:email],
        "button[site]" => software_button_params[:site],
        "button[external_reference]" => SecureRandom.hex(6).upcase.scan(/../).join(":"),
      },
    )
    json_response = JSON.parse(response.body)
    [response, json_response]
  end
end
