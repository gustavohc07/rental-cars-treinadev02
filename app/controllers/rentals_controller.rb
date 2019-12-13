class RentalsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
    @cars = @rental.car_category.cars # o through no model permite que façamos isso.
    # @cars = Car.joins(:car_model).where(car_models: {car_category: @rental.car_category})
    # primeira parte é o nome da associação e a segunda é o nome da tabela
    # Se a associação for de belongs_to a primeira parte fica no singular. Caso seja
    # uma associação de has_many, seria no plural a primeira parte (o joins)f.check_box :
    # Where sempre no plural.
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


  # where retorna uma coleção. Caso não encontre ele retorna nil. Busca por igualdade total. Para parcial o sqlite não tem o like, terá
  # que ser feito à mão
  # find buscar por id
  # find_by busca pelo que a gente quiser, porem retorna sempre o primeiro que ele encontrar
  def search
    @rentals = Rental.where('reservation_code like?', "%#{params[:q]}%")

    render :index  # cospe a view da index com o novo @rentals - abordagem não clássica
    #TODO criar a view de search com calma. Solução acima serve como solução mas pode criar complexidade na view do index.
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

  def start #criei para acompanhar a aula
    @rental = Rental.find(params[:id])
    @rental.in_progress!  # = @rental.update(status: :in_progress)
  
    @car = Car.find(params[:rental][:car_id])
    @car.rented!
    @rental.create_car_rental(car: @car, price: @car.price)
    flash[:notice] = 'Locação efetivada com sucesso!'
    redirect_to @rental

    # Com enum ganhamos metodos de classe -> Rental.scheduled retorna todas as locações agendadas.
  end

  private



  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :car_category_id,
                                   :client_id)
  end
end


# @car = Car.find(params[:rental][:car_id])
# 