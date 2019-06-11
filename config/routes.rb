Rails.application.routes.draw do
  get 'test' => 'test#index'
  get 'test/mypage' => 'test#mypage', as: 'mypage'
  root 'test#index'
  get 'detail', to: 'test#detail'
end
