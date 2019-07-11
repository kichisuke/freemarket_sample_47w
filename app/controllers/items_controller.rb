class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @categories = Category.eager_load(children: :children).where(parent_id: nil)
    @item = Item.new
    @item.item_images.build
    @item.build_brand
  end

  def create
    @categories = Category.all
    @item = Item.new(item_params)
    if @item.save
      params[:item_images][:image].each do |url|
        @item.item_images.create(url: url, item_id: @item.id)
      end
      redirect_to root_path, notice: '出品しました。'
    end
  end

  def category_search
    respond_to do |format|
      format.html
      format.json do
        @parent_category = Category.find(params[:parent_id])
        @child_categories = @parent_category.children
      end
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :category_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status, item_images_attributes: [:url], brand_attributes: [:id, :name])
  end

  #下記コードは何してるかわからない
  # def to_int_category_id
  #   item_params.tap do |ip|
  #     ip[:category_id] = ip[:category_id].to_i
  #   end
  # end
end
