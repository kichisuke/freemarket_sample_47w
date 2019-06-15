Rails.application.routes.draw do
  get 'test' => 'test#index'
  get 'test/mypage' => 'test#mypage', as: 'mypage'
  get 'test/signup' => 'test#signup'
  get 'test/registration' => 'test#registration'
  get 'test/sms_confirmation' => 'test#sms_confirmation'
  get 'test/input_address' => 'test#input_address'
  root 'test#index'
end
