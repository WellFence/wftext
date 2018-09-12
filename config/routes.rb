Rails.application.routes.draw do

  post 'twilio/sms'
  post 'people/index'
  post 'people/mark_completed'
  post 'people/waiting'

  resources :people
  
  get 'people/new'
  get 'welcome/index'
  root 'welcome#index'

end
