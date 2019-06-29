class ItemsController < ApplicationController
  def index
  end
  
  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # @item = Item.create(name: params[:name], price: params[:price], text: params[:text])

    # binding.pry
     if @item.save
      redirect_to root_path, notice: '出品しました。'
     #else
       #render "items/new"
     end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :condition, :delivery_charge, :delivery_source_area, :estimated_shipping_date)
  end

  # private
  # def item_params
  #   params.require(:item).permit(
  #     :name,
  #     :text,
  #     :condition,
  #     :delivery_charge,
  #     # :delivery_method,
  #     :delivery_source_area,
  #     :estimated_shipping_date,
  #     :price
  #   )
  # end
end
