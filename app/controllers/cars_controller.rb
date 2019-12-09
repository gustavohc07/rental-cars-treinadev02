class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_car_collection, only: [:new, :create]

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
      set_car_collection
      render :new
    end
  end

  def edit
    @car = Car.find(params[:id])
    set_car_collection
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      flash[:notice] = 'Atualizado com sucesso!'
      redirect_to @car
    else
      set_car_collection
      render :edit
    end
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :car_model_id,
                                :mileage, :subsidiary_id)
  end

  def set_car_collection
    @car_categories = CarCategory.all
    @subsidiaries = Subsidiary.all
    @car_models = CarModel.all
  end

  def authorize_admin
    redirect_to root_path, notice: 'Você não tem autorização!' unless current_user.admin?
  end
end
