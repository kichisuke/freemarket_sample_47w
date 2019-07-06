# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_sign_up_params

  def signup
  end

  def registration
  end

  def sms_confirmation
    session[:nickname] = params[:session][:nickname]
    session[:email] = params[:session][:email]
    session[:password] = params[:session][:password]
    session[:password_confirmation] = params[:session][:password_confirmation]
    session[:family_name] = params[:session][:family_name]
    session[:first_name] = params[:session][:first_name]
    session[:family_name_kana] = params[:session][:family_name_kana]
    session[:first_name] = params[:session][:first_name_kana]
    session[:birthday] = Date.new(params[:session]["birthday(1i)"].to_i, params[:session]["birthday(2i)"].to_i, params[:session]["birthday(3i)"].to_i)
  end

  def input_address
    session[:phone_number] = params[:session][:phone_number]
  end

  def payment
    # session[:family_name] = params[:session][:family_name]
    # session[:first_name] = params[:session][:first_name]
    # session[:family_name_kana] = params[:session][:family_name_kana]
    # session[:first_name] = params[:session][:first_name_kana]
    session[:postal_code] = params[:session][:postal_code]
    session[:prefecture_id] = params[:session][:prefecture_id]
    session[:city] = params[:session][:city]
    session[:street_address] = params[:session][:street_address]
    session[:building] = params[:session][:building]
  end

  def signup_create
    @user = User.new(nickname: session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation])
    uid = @user.id
    binding.pry
    Plofile.new(family_name: session[:family_name], first_name: session[:first_name], family_name_kana: session[:family_name_kana], first_name_kana: session[:first_name_kana], birthday: session[:birthday], user_id: uid)
    Address.new(postalcode: session[:postal_code], prefecture_id: session[:prefecture_id], city: session[:city], street_address: session[:street_address], building: session[:building], phone_number: session[:phone_number], user_id: uid)
    Creditcard.new(token: params[:payjp_token], user_id: uid)
    redirect_to signup_end_path
  end

  def signup_end
  end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar_image])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
