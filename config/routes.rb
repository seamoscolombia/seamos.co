Rails.application.routes.draw do
  get 'photos/create'

  root 'intro#inicio'

  resources :photos, only: :create
  resources :usuarios, only: [:new, :create]

  #ToDo ajax call on session
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/auth/sessions', to: 'sessions#error'

  resources :polls, except: [:destroy, :update]
  resources :tipo_de_documentos, only: :index
  resources :votes, only: :create



end
