class CarModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_car_models, only: [:show, :edit, :update, :destroy]

  def index
    @car_models = CarModel.all
  end

  def show
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
      set_collection
      render :new
    end
  end

  def edit
    @car_model = CarModel.find(params[:id])
    set_collection
  end

  def update
    if @car_model.update(car_model_params)
      flash[:notice] = 'Modelo de carro atualizado com sucesso'
      redirect_to @car_model
    else
      set_collection
      render :edit
    end
  end

  private
  def car_model_params
    params.require(:car_model).permit(:name, :fuel_type, :motorization,
                                      :car_category_id, :year, :manufacturer_id)
  end

  def authorize_admin
    redirect_to root_path, notice: 'Você não tem autorização!' unless current_user.admin?
  end

  def set_car_models
    @car_model = CarModel.find(params[:id])
  end

  def set_collection
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end
end