Rails.application.routes.draw do

  root 'intro#inicio'

  resources :photos, only: :create
  resources :usuarios , except: [:new, :show]

  #ToDo ajax call on session
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/auth/sessions', to: 'sessions#error'

  resources :polls, except: [:destroy, :update]
  resources :tipo_de_documentos, only: :index
  resources :votes, only: :create

  scope '/admin' do
    # get '/', to: 'sessions#new'
    get '/', to: 'intro#index'
    get 'validate-users', to: 'usuarios#index'
    resources 'dashboard', only: :index
  end


end
