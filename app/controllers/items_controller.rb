class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @otherItems = Item.where(saler_id: @item.saler.id).where.not(id: params[:id]).limit(3)
    @sameCategories = Item.where(category_id: @item.category.id).where.not(id: params[:id]).limit(3)
  end

  def new
  end
end
