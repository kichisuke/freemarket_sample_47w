Rails.application.routes.draw do
  get 'test' => 'test#index'
  get 'test/mypage' => 'test#mypage', as: 'mypage'
  get 'test/mypage/profile' => 'test#profile'
  root 'test#index'
end
