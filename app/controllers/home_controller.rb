class HomeController < ApplicationController
  def index 
    @fabricantes = Manufacturer.all
  end

  def show
    
  end
end