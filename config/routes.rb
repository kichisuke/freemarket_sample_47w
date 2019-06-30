Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions'
                                  }
  root 'items#index'
  resources :items do
    collection do
      get :category_search
      get :brand_search
      get "search"
      get ':id/purchase', to: 'items#purchase'
      post ':id/pay', to: 'items#pay'
    end
  end

  devise_scope :user do
    get 'mypage', to: 'users/sessions#mypage'
    get 'mypage/profile', to: 'users/sessions#profile'
    get 'mypage/card', to: 'users/sessions#card'
    get 'mypage/identification', to: 'users/sessions#user_identification'
    get 'login', to: 'users/sessions#new'
    get 'logout', to:'users/sessions#logout'
    get 'signup', to: 'users/registrations#signup'
    get 'registration', to: 'users/registrations#registration'
    get 'sms_confirmation', to: 'users/registrations#sms_confirmation'
    post 'sms_confirmation', to: 'users/registrations#sms_confirmation'
    get 'input_address', to: 'users/registrations#input_address'
    post 'input_address', to: 'users/registrations#input_address'
    post 'payment', to: 'users/registrations#payment'
    post 'signup_create', to: 'users/registrations#signup_create'
    get 'signup_end', to: 'users/registrations#signup_end'
  end
end
