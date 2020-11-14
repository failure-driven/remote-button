class ButtonsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @button = Button.new
    @button.save!
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
