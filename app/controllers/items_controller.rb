class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def purchase
    @item = Item.find(params[:id])
    @user = User.find(1)
  end

  def pay
    @item = Item.find(params[:id])
    @user = User.find(1)
    @item.buyer_id = @user.id
    @item.sales_status = 2
    @item.save
  end
end
