class UsersController < ApplicationController
  def mypage
    @user = User.find(1)
    @tradings = Item.where(buyer_id: @user.id, sales_status: "trading")
  end

  def profile
  end

end