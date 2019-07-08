class ItemsController < ApplicationController
  before_action :set_item, except: [:index]

  def index
    #レディースカテゴリーの4アイテムを最新の上から4つ抽出
    @top_item1 = Item.where("category_id = '1'").order('created_at DESC').limit(4)
    #メンズカテゴリーの4アイテムを最新の上から4つ抽出
    @top_item2 = Item.where("category_id = '2'").order('created_at DESC').limit(4)
  end

  def show
    @otherItems = Item.where(saler_id: @item.saler.id).where.not(id: params[:id]).limit(3)
    @sameCategories = Item.where(category_id: @item.category.id).where.not(id: params[:id]).limit(3)
    @previousItem = Item.where('id < ?', params[:id]).order('id DESC').first
    @nextItem = Item.where('id > ?', params[:id]).order('id ASC').first
  end

  def new
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
