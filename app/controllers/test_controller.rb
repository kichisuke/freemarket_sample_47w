class TestController < ApplicationController
  def index
  end

  def sell
    @item = Item.new
  end
  
  def profile
  end

  def mypage
  end

  def purchase
  end
end
