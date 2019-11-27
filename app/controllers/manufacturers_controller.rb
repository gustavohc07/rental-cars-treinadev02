class ManufacturersController < ApplicationController
  def index 
    @fabricantes = Manufacturer.all
  end

  def show
    @fabricante = Manufacturer.find(params[:id])
  end
end