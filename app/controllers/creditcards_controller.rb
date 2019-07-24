class CreditcardsController < ApplicationController
  require 'payjp'
  def new
  end

  def create
    Payjp.api_key = 'sk_test_5807e2b2840ba0fcf414ec61'
    
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

end
