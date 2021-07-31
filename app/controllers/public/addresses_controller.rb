class Public::AddressesController < ApplicationController
  def index
    @customer_addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      @customer_addresses = current_customer.addresses
      @address = Address.new
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      @address = Address.find(params[:id])
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_to addresses_path
    else
      @address = Address.find(params[:id])
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :customer_id)
  end
end
