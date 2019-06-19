class TestController < ApplicationController
  def index
  end

  def sell
    @item = Item.new
  end
  
  def mypage
  end
end
