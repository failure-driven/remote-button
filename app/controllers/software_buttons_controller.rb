class SoftwareButtonsController < ApplicationController
  def new
    @button = Button.new
  end

  def create; end
end
