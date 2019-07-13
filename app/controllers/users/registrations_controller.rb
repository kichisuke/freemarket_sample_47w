class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :check_captcha, only: [:sms_confirmation]

  def signup
  end

  def registration
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
    @address = Address.new(session[:address])
    @credit = Creditcard.new(token: params[:payjp_token], user_id: current_user.id)
    if @address.save && @credit.save
      redirect_to signup_end_path
    else
      redirect_to input_address_path
    end
  end

  def signup_end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  def user_params
    params.require(:session).permit(:nickname,:email,:password,:password_confirmation)
  end

  def profile_params
    birthday = Date.new(params[:session]["birthday(1i)"].to_i, params[:session]["birthday(2i)"].to_i, params[:session]["birthday(3i)"].to_i)
    params.require(:session).permit(:family_name, :first_name, :family_name_kana, :first_name_kana).merge(birthday: birthday)
  end

  def address_params
    params.require(:session).permit(:postal_code, :prefecture_id, :city, :street_address, :building, :phone_number).merge(user_id: current_user.id)
  end
end
