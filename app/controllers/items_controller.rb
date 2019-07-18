class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

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

  def brand_search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :category_id, :brand_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status, item_images_attributes: [:url])
  end

  #下記コードは何してるかわからない
  # def to_int_category_id
  #   item_params.tap do |ip|
  #     ip[:category_id] = ip[:category_id].to_i
  #   end
  # end
  private
  def set_item
    @item = Item.find(params[:id])
  end
end
