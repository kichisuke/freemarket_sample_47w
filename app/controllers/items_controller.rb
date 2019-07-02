class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @images = ItemImage.where(item_id: params[:id])
    @otherItems = Item.where(saler_id: @item.saler.id).where.not(id: params[:id]).limit(3)
  end

  def new
  end
end
