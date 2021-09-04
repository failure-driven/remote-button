class ButtonsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @button = Button.new(button_params)
    @button.save!
    UserMailer.with(button: @button).button_registration.deliver_later
    render json: {button_url: button_url(@button)}, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: {error: e.message}, status: :unprocessable_entity
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
    @total_events_count = @button.events.count
    @events = @button.events.page params[:page]
  end

  def mode_report
    @button = Button.find(params[:id])
    # @reports = @button.mode.properties["reports"].create_report # which will
    @mode = Mode.first
    @reports = @mode.properties["reports"]
    @data = @mode.properties["dataGeneratorMethod"]
  end

  def edit
    @button = Button.find(params[:id])
  end

  def update
    @button = Button.find(params[:id])
    @button.update(button_params) ? (redirect_to button_path(@button)) : (render :new)
  end

  def all_my_buttons
    @button = Button.find(params[:id])
    @buttons = Button.where(email: @button.email)
  end

  private

  def button_params
    return unless params[:button]

    params.require(:button).permit(:email, :site, :external_reference, :name)
  end
end
