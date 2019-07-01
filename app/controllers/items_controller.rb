class ItemsController < ApplicationController
  def index
  end

  def show
    #@item = Item.find(params[:id])
    @item = Item.find(1)
    @images = ItemImage.where(item_id: 1)
    @otherItems = Item.where(saler_id: 1).where.not(id: 1).limit(3)
  end

  def new
  end
end
