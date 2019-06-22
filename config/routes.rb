Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items

  devise_scope :user do
    get 'mypage', to: 'users/sessions#mypage'
    get 'mypage/profile', to: 'users/sessions#profile'
    get 'mypage/card', to: 'users/sessions#card'
    get 'mypage/identification', to: 'users/sessions#user_identification'
    get 'registration', to: 'users/registrations#registration'
  end

  # get 'test', to: 'test#index'
  # get 'test/mypage', to: 'test#mypage', as: 'mypage'
  # get 'test/mypage/profile', to: 'test#profile'
  # get 'test/mypage/card', to: 'test#card'
  # get 'test/mypage/identification', to: 'test#user_identification'
  # get 'test/mypage/logout', to: 'test#logout'
  # get 'test/purchase', to: 'test#purchase', as: 'purchase'
  # get 'signup', to: 'test#signup'
  # get 'login', to: 'test#login'
  # get 'registration', to: 'test#registration'
  get 'sms_confirmation', to: 'test#sms_confirmation'
  get 'input_address', to: 'test#input_address'
  get 'payment', to: 'test#payment'
  get 'signup_end', to: 'test#signup_end'
  # root 'test#index'
  get 'test/sell', to: 'test#sell'
  get 'detail', to: 'test#detail'
end
