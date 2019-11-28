class CarCategoriesController < ApplicationController
  def index
    @categorias = CarCategory.all
  end

  def show
    @categoria = CarCategory.find(params[:id])
  end
end
