class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new
    @order = Customer.find(current_customer.id)
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      @cart_item = CartItem.new
      @order = current_customer.orders
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      session[:cart_item_id] = nil
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      @cart_item = CartItem.new
      @order = current_customer.orders
      render :index
    end
  end

  def alldestroy
    @cart_items = current_customer.cart_items
    if @cart_items.destroy_all
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      @cart_item = CartItem.new
      @order = current_customer.orders
      render :index
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      @cart_item = CartItem.new
      render :index
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end
