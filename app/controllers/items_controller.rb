class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :search, :new]

  def index
    #レディースカテゴリーの4アイテムを最新の上から4つ抽出
    @radiesItem = pickup_category_items(1)
    #メンズカテゴリーの4アイテムを最新の上から4つ抽出
    @mensItem = pickup_category_items(2)
  end

  def pickup_category_items(id)
    # 引数で渡されたidの子カテゴリのidの配列を生成
    child_category_ids = Category.find(id).children.ids
    # 子カテゴリのidと合致する孫カテゴリのidの配列を生成
    grand_child_category_ids = Category.where("parent_id IN (?)", child_category_ids).ids
    # 孫カテゴリのidと合致するitemsの配列を生成
    items = Item.where("category_id IN (?)", grand_child_category_ids)
    # 最新の４件を取得
    items.order("created_at DESC").limit(4)
  end

  def show
    @otherItems = Item.where(saler_id: @item.saler.id).where.not(id: params[:id]).limit(3)
    @sameCategories = Item.where(category_id: @item.category.id).where.not(id: params[:id]).limit(3)
    @previousItem = Item.where('id < ?', params[:id]).order('id DESC').first
    @nextItem = Item.where('id > ?', params[:id]).order('id ASC').first
  end

  def new
  end

  def search
    @items = Item.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
