class Admin::HomesController < ApplicationController
  def top
    @customers = Customer.all
    @orders = Order.all
    @order_details = OrderDetail.all
  end
end
