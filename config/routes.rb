Rails.application.routes.draw do

  root 'intro#inicio'

  resources :usuarios
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/sessions', to: 'sessions#error'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
