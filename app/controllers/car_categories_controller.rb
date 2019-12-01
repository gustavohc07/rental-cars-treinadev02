class CarCategoriesController < ApplicationController
  def index
    @categories = CarCategory.all
  end

  def show
    @category = CarCategory.find(params[:id])
  end

  def new
    @category = CarCategory.new
  end

  def create
    @category = CarCategory.new(car_categories_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  private

  def car_categories_params
    params.require(:car_category).permit(:name, :car_insurance, :daily_rate,
                                         :third_party_insurance)
  end
end
