Rails.application.routes.draw do
  root 'test#index'
  get 'test/sell' => 'test#sell'
end
