class UsersController < ApplicationController
  def mypage
    @tradings = Item.where(buyer_id: current_user.id, sales_status: "trading")
  end

  def profile
  end

end
