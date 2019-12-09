class SubsidiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_subsidiary, only: [:show, :edit, :update, :destroy]

  def index
    @subsidiaries = Subsidiary.all
  end

  def show
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      redirect_to @subsidiary
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subsidiary.update(subsidiary_params)
      redirect_to @subsidiary
    else
      render :new
    end
  end

  def destroy
    @subsidiary.destroy
    redirect_to subsidiaries_path
  end

  private

  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def authorize_admin
    redirect_to root_path, notice: 'Você não tem autorização!' unless current_user.admin?
  end

  def set_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end
end