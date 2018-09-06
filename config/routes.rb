Rails.application.routes.draw do

  post 'twilio/sms'

  resources :people

  get 'welcome/index'

  root 'welcome#index'

end
