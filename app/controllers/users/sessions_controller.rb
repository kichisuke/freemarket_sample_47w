class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  end

  def logout
  end

  def card
    require 'payjp'
    @card = Creditcard.where(user_id: current_user.id).first
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @card_information.brand
    end
  end
end
