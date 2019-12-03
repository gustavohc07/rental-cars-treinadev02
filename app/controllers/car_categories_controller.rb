class CarCategoriesController < ApplicationController
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_categories_params)
    if @car_category.save
      redirect_to @car_category
    else
      render :new
    end
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def update
    @car_category = CarCategory.find(params[:id])
    if @car_category.update(car_categories_params)
      redirect_to @car_category
    else
      render :edit
    end
  end

  private

  def car_categories_params
    params.require(:car_category).permit(:name, :car_insurance, :daily_rate,
                                         :third_party_insurance)
  end
end
