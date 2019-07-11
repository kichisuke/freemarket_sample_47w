Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items do
    collection do
      get :category_search
    end
  end

  devise_scope :user do
    get 'mypage', to: 'users/sessions#mypage'
    get 'mypage/profile', to: 'users/sessions#profile'
    get 'mypage/card', to: 'users/sessions#card'
    get 'mypage/identification', to: 'users/sessions#user_identification'
    get 'registration', to: 'users/registrations#registration'
  end

  #下記は一旦残しておく
  get 'sms_confirmation', to: 'test#sms_confirmation'
  get 'input_address', to: 'test#input_address'
  get 'payment', to: 'test#payment'
  get 'signup_end', to: 'test#signup_end'
  get 'test/sell', to: 'test#sell'
  get 'detail', to: 'test#detail'
end
