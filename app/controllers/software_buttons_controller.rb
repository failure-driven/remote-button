class SoftwareButtonsController < ApplicationController
  def new
    @button = Button.new
  end
end
