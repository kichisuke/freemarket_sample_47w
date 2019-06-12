Rails.application.routes.draw do
  get 'test' => 'test#index'
  get 'test/mypage' => 'test#mypage', as: 'mypage'
  get 'test/signup' => 'test#signup'
  get 'test/registration' => 'test#registration'
  root 'test#index'
end
