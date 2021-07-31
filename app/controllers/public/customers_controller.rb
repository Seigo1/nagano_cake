class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(current_customer.id)
  end

  def destroy
    @customer = Customer.find(current_customer.id)
    if @customer.update(is_active: "無効")
      reset_session
      redirect_to root_path
    else
      render :unsubscribe
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
