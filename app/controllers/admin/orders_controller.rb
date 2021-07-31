class Admin::OrdersController < ApplicationController
  def edit
    @order = Order.find(params[:id])
    @customer = Customer.find_by(id: params[:customer_id])
    @cart_items = CartItem.where(@order_id)
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  def orderstatus
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to edit_admin_order_path(@order.id), notice: 'You have updated customer successfully.'
    else
      render :edit
    end
  end

  def productstatus
    @making = OrderDetail.find(params[:id])
    if @making.update(order_params)
      redirect_to edit_admin_order_path(@making.id), notice: 'You have updated customer successfully.'
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def making_params
    params.require(:order_detail).permit(:making_status)
  end
end
