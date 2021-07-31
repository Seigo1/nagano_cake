class Public::OrdersController < ApplicationController

  def new
    @addresses = Address.where(customer_id: current_customer.id)
    @customer = Customer.find(current_customer.id)
    @cart_items = current_customer.cart_items
    @order = Order.new
  end

  def confirm
    # newでチェックした項目で住所、郵便番号、宛名が変わる。
    if params[:order][:address_type] == "1"
      @address = Customer.find(current_customer.id)
      @postal_code = Customer.find(current_customer.id)
      @name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_type] == "2"
      @address = Address.find(params[:order][:address_id])
      @postal_code = Address.find(params[:order][:address_id])
      @name = Address.find(params[:order][:address_id])
    elsif params[:order][:address_type] == "3"
      @address = params[:order][:address]
      @postal_code = params[:order][:postal_code]
      @name = params[:order][:name]
    elsif params[:order][:address_type] == nil
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items
    # 条件を指定して初めの1件を取得し1件もなければ作成(new)。
    if @order = Order.find_or_initialize_by(id: params[:id])
      @order.assign_attributes(order_params)
      if params[:order][:address_type] == "1"
        @order.address = @address.address
        @order.postal_code = @postal_code.postal_code
        @order.name = @name
      elsif params[:order][:address_type] == "2"
        @order.address = @address.address
        @order.postal_code = @postal_code.postal_code
        @order.name = @name.name
      end
    else
      redirect_to new_order_path
    end
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @price = @order.total_payment + @order.shipping_cost
    @item = current_customer.cart_items
    @order.save
    # order_detailの保存
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.amount = cart_item.amount
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item.id
      @order_detail.price = (cart_item.item.add_tax_price.to_i * cart_item.amount)
      @order_detail.save
    end
    redirect_to orders_thanks_path
  end

  def index
    @customer = Customer.find(current_customer.id)
    @orders = @customer.orders
    @order = Order.new
    @cart_items = current_customer.cart_items
  end

  def show
    @customer = Customer.find(current_customer.id)
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

  def order_detail_params
    params.permit(:amount, :item_id, :order_id, :price, :making_status)
  end

end
