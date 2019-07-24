class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :purchase, :pay, :done]

  require "payjp"

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

end
