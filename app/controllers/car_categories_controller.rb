class CarCategoriesController < ApplicationController
  def index
    @categories = CarCategory.all
  end

  def show
    @category = CarCategory.find(params[:id])
  end
end
