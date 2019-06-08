Rails.application.routes.draw do
  get '/' => 'test#index'
  get 'test' => 'test#index'
  get 'profile' => 'test#profile'
end
