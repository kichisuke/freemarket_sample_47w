class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def purchase
    @item = Item.find(params[:id])
    @user = User.find(1)
  end
end
