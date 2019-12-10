class RentalsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to @rental, notice: 'Locação agendada com sucesso'
    else
      @clients = Client.all
      @car_categories = CarCategory.all
    end
  end

  def search
  end

  def activate
    @rental = Rental.find(params[:id])
    @rental.scheduled!
    flash[:notice] = 'Locação efetivada com sucesso!'
    redirect_to rentals_path
  end

  def cancel
    @rental = Rental.find(params[:id])
    @rental.canceled!
    flash[:notice] = 'Locação cancelada!'
    redirect_to rentals_path
  end

  private



  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :car_category_id,
                                   :client_id)
  end
end