Rails.application.routes.draw do

  root 'intro#inicio'

  resources :usuarios

  #ToDo ajax call on session
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/auth/sessions', to: 'sessions#error'
end
