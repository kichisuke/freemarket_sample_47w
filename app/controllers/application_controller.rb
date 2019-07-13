class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # def check_captcha
  #   unless verify_recaptcha(model: resource)
  #     self.resource = resource_class.new sign_up_params
  #     resource.validate
  #     respond_with_navigational(resource) { render :registration }
  #   end
  # end
end
