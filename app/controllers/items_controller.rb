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
    if new_image_params[:images][0].present? && @item.save
      new_image_params[:images].each do |url|
        @item.item_images.create(url: url, item_id: @item.id)
      end
      redirect_to root_path, notice: '出品しました。'
    else
      render :new, alert: '出品出来ませんでした。'
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
    params.require(:item).permit(:name, :price, :text, :category_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status, brand_attributes: [:id, :name]).merge(saler_id: current_user.id)
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end
end
