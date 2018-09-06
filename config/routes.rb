Rails.application.routes.draw do

  post 'twilio/sms'

  resources :people

  get 'people/new'

  get 'welcome/index'

  root 'welcome#index'

end
