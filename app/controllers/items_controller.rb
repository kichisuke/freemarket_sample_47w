class ItemsController < ApplicationController
  before_action :set_item, only: [:purchase, :pay, :done]

  require "payjp"

  def index
  end

  def show
  end

  def new
  end

  def purchase
    @user = User.find(1)
  end

  def pay
    @user = User.find(1)
    @item.buyer_id = @user.id
    @item.sales_status = 2
    @item.save
    redirect_to action: 'done'
  end

  def done
    @user = User.find(1)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
