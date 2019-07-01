class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @categories = Category.all
    @item = Item.new
  end

  def create
    @categories = Category.all
    @item = Item.new(to_int_category_id)
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
    params.require(:item).permit(:name, :price, :text, :category_id, :condition, :delivery_charge, :prefecture_id, :estimated_shipping_date)
  end

  def to_int_category_id
    item_params.tap do |ip|
      ip[:category_id] = ip[:category_id].to_i
    end
  end

  # private
  # def item_params
  #   params.require(:item).permit(
  #     :name,
  #     :text,
  #     :condition,
  #     :delivery_charge,
  #     # :delivery_method,
  #     :prefecture_id,
  #     :estimated_shipping_date,
  #     :price
  #   )
  # end
end
