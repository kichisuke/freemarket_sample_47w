class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def google_oauth2
    callback_from :google_oauth2
  end

  private
  def callback_from(provider)
    provider = provider.to_s
    sns_user = User.find_for_oauth(request.env['omniauth.auth'])
    if sns_user.persisted?
      sign_in_and_redirect sns_user, event: :authentication
    elsif
      session[:sns_user] = sns_user
      redirect_to registration_path
    else
      redirect_to signup_path
    end
  end
end
