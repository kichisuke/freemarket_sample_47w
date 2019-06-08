Rails.application.routes.draw do
  root 'test#index'
  get 'detail', to: 'test#detail'
end
