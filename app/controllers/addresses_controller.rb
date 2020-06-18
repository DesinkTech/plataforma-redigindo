class AddressesController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = Address.paginate(page: params[:page], per_page: 16)
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to addresses_path, success: "Cidade inserida com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, success: "Cidade alterada com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path, success: "Cidade removida com sucesso"
  end

  private

  def set_address
    @address = Address.find_by(id: params[:id])
  end

  def address_params
    params.require(:address).permit(:city, :state)
  end
end
