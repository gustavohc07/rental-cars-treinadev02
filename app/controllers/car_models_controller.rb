class CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(car_model_params)
    if @car_model.save
      redirect_to @car_model
      flash[:notice] = 'Modelo registrado com sucessso'
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  def edit
    @car_model = CarModel.find(params[:id])
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def update
    @car_model = CarModel.new(car_model_params)
  end

  private
  def car_model_params
    params.require(:car_model).permit(:name, :fuel_type, :motorization,
                                      :car_category_id, :year, :manufacturer_id)
  end
end