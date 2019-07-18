class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new]

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
  end

  def destroy
    if @item.saler_id == current_user.id
      @item.destroy
      @item.item_images.destroy
      redirect_to root_path、 notice: "削除しました"
    else
      redirect_to root_path、 notice: "削除できません"
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
