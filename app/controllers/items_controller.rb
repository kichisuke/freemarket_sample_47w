class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :move_to_login, only: [:new]

  def index
    #レディースカテゴリーの4アイテムを最新の上から4つ抽出
    @radiesItem = Item.topItem(1)
    #メンズカテゴリーの4アイテムを最新の上から4つ抽出
    @mensItem = Item.topItem(2)
  end

  def show
    @otherItems = Item.where(saler_id: @item.saler.id).where.not(id: params[:id]).limit(3)
    @sameCategories = Item.where(category_id: @item.category.id).where.not(id: params[:id]).limit(3)
    @previousItem = Item.where('id < ?', params[:id]).order('id DESC').first
    @nextItem = Item.where('id > ?', params[:id]).order('id ASC').first
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

  def brand_search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :category_id, :brand_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status, brand_attributes: [:id, :name], item_images_attributes: [:url]).merge(saler_id: current_user.id)
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_login
    redirect_to controller: 'users/sessions', action: 'new' unless user_signed_in?
  end
end
