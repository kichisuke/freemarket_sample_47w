class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :purchase, :pay, :done]
  before_action :move_to_login, only: [:new]

  require "payjp"

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
    @otherItems = Item.where(saler_id: @item.saler_id).where.not(id: params[:id]).limit(3)
    @sameCategories = Item.where(category_id: @item.category_id).where.not(id: params[:id]).limit(3)
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

  def search
    @items = Item.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  def destroy
    if @item.saler_id == current_user.id
      @item.destroy
      @item.item_images.destroy
      redirect_to root_path, notice: "削除しました"
    else
      redirect_to root_path, notice: "削除できません"
    end
  end

  def purchase
    @card = Creditcard.where(user_id: current_user.id).first
    if @card.present?
      Payjp.api_key = 'sk_test_5807e2b2840ba0fcf414ec61'
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @card_information.brand
    end
  end

  def pay
    card = Creditcard.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_5807e2b2840ba0fcf414ec61'
    Payjp::Charge.create(customer: card.customer_id, amount: @item.price, currency: 'jpy')
    @item.buyer_id = current_user.id
    @item.sales_status = 2
    @item.save
    redirect_to action: 'done'
  end

  def done
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :text, :category_id, :brand_id, :size, :condition, :delivery_charge, :delivery_method, :prefecture_id, :estimated_shipping_date, :sales_status).merge(saler_id: current_user.id)
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

  def purchase
    @user = User.find(1)
  end

  def pay
    @user = User.find(1)
    @item.buyer_id = @user.id
    @item.sales_status = 2
    @item.save
    redirect_to action: 'done'
  end

  def done
    @user = User.find(1)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
