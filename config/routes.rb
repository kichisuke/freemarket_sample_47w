Rails.application.routes.draw do
  get 'test', to: 'test#index'
  get 'test/mypage', to: 'test#mypage', as: 'mypage'
  get 'test/mypage/profile', to: 'test#profile'
  get 'test/purchase', to: 'test#purchase', as: 'purchase'
  root 'test#index'
  get 'test/sell' => 'test#sell'
  get 'detail', to: 'test#detail'
end
