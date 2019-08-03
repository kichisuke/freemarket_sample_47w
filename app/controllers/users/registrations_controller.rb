class Users::RegistrationsController < Devise::RegistrationsController
  def signup
    session[:sns_user] = nil
  end

  def registration
    if session[:sns_user].present?
      @sns_user = User.new(nickname: session[:sns_user]["nickname"],
                       email: session[:sns_user]["email"],
                       uid: session[:sns_user]["uid"],
                       provider: session[:sns_user]["provider"])
      session[:sns_user] = nil
    else
      @sns_user = User.new
    end
  end

  def sms_confirmation
    session[:user] = user_params
    session[:profile] = profile_params
  end

  def create
    @user = User.new(session[:user])
    @user.profile = @user.build_profile(session[:profile])
    if @user.save
      sign_up(@user, current_user)
      session[:user] = nil
      session[:profile] = nil
      redirect_to input_address_path
    else
      redirect_to registration_path
    end
  end

  def input_address
  end

  def payment
    session[:address] = address_params
  end

  def signup_create
    require 'payjp'
    @address = Address.new(session[:address])

    Payjp.api_key = "sk_test_5807e2b2840ba0fcf414ec61"
    customer = Payjp::Customer.create(description: 'test', card: params[:payjp_token])
    @credit = Creditcard.new(token: params[:payjp_token], user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
    if @address.save! && @credit.save!
      session[:address] = nil
      redirect_to signup_end_path
    else
      redirect_to input_address_path
    end
  end

  def signup_end
  end

  private
  def user_params
    params.require(:session).permit(:nickname, :email, :password, :password_confirmation, :uid, :provider)
  end

  def profile_params
    birthday = Date.new(params[:session]["birthday(1i)"].to_i, params[:session]["birthday(2i)"].to_i, params[:session]["birthday(3i)"].to_i)
    params.require(:session).permit(:family_name, :first_name, :family_name_kana, :first_name_kana).merge(birthday: birthday)
  end

  def address_params
    params.require(:session).permit(:postal_code, :prefecture_id, :city, :street_address, :building, :phone_number).merge(user_id: current_user.id)
  end
end
