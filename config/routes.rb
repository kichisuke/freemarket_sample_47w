Rails.application.routes.draw do
  get '/' => 'test#index'
  get 'test' => 'test#index'
  get 'test/mypage' => 'test#mypage', as: 'mypage'
end
