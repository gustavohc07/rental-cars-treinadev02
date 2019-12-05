class CarModelsController < ApplicationController
  def index 
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
      flash[:notice] = 'Modelo registrado com sucesso'
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      render :new
    end
  end

  private
  def car_model_params
    params.require(:car_model).permit(:name, :fuel_type, :motorization,
                                      :car_category_id, :year, :manufacturer_id)
  end
end