class ItemsController < ApplicationController
  def index
    #レディースカテゴリーの4アイテムを最新の上から4つ抽出
    @top_item1 = Item.where("category_id = '1'").order('created_at DESC').limit(4)
    #メンズカテゴリーの4アイテムを最新の上から4つ抽出
    @top_item2 = Item.where("category_id = '2'").order('created_at DESC').limit(4)
  end

  def show
  end

  def new
  end
end
