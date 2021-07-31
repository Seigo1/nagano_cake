class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @items_count = Item.where(params[:id]).count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
