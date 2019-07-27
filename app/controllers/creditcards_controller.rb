class CreditcardsController < ApplicationController
  require 'payjp'
  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to new_creditcard_path
    else
      customer = Payjp::Customer.create(description: 'test', card: params['payjp-token'])
      @creditcard = Creditcard.new(user_id: current_user.id, customer_id: customer.id, token: params['payjp-token'], card_id: customer.default_card)
      if @creditcard.save
        redirect_to root_path
      else
        redirect_to new_creditcard_path
      end
    end
  end

  def destroy
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    @card = Creditcard.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to mypage_card_path, notice: "削除しました"
    else
      redirect_to mypage_card_path, alert: "削除できませんでした"
    end
  end

end
