class ManufacturersController < ApplicationController
  def index 
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    # @manufacturer = .new
  end

  def create

  end
  
end