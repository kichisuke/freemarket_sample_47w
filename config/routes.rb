Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions'
                                  }
  root 'items#index'
  resources :items

  devise_scope :user do
    get 'mypage', to: 'users/sessions#mypage'
    get 'mypage/profile', to: 'users/sessions#profile'
    get 'mypage/card', to: 'users/sessions#card'
    get 'mypage/identification', to: 'users/sessions#user_identification'
    get 'signup', to: 'users/registrations#signup'
    get 'registration', to: 'users/registrations#registration'
    get 'sms_confirmation', to: 'users/registrations#sms_confirmation'
    post 'sms_confirmation', to: 'users/registrations#sms_confirmation'
    get 'input_address', to: 'users/registrations#input_address'
    post 'input_address', to: 'users/registrations#input_address'
    get 'payment', to: 'users/registrations#payment'
    post 'payment', to: 'users/registrations#payment'
    post 'signup_create', to: 'users/registrations#signup_create'
    get 'signup_end', to: 'users/registrations#signup_end'
  end

  #下記は一旦残しておく
  get 'test/sell', to: 'test#sell'
  get 'detail', to: 'test#detail'
end
