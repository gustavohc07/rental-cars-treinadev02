class RentalsController < ApplicationController

  def index
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

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :car_category_id,
                                   :client_id)
  end
end