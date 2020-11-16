class ButtonsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @button = Button.new(button_params)
    @button.save!
    render json: { button_url: button_url(@button) }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def show
    @button = Button.find(params[:id])
  end

  def event
    @button = Button.find(params[:id])
    @button.events.create
  end

  def report
    @button = Button.find(params[:id])
    @events = @button.events
  end

  private

  def button_params
    return unless params[:button]

    params.require(:button).permit(:email, :site, :external_reference)
  end
end
