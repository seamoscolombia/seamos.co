Rails.application.routes.draw do

  root 'intro#inicio'

  resources :photos, only: :create
  resources :usuarios , except: [:new, :show] do
    get 'already_voted', on: :member
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/auth/sessions', to: 'sessions#error'

  resources :polls do
    get 'last', on: :collection
    get 'voted', on: :collection
    resources :debates, on: :collection #, except: :create
    # post 'debates', to: 'debates#create'
  end
  resources :tipo_de_documentos, only: :index
  resources :votes, only: :create

  scope '/admin' do
    # get '/', to: 'sessions#new'
    get 'polls', to:  'polls#index_admin', as: :admin_polls
    get '/', to: 'intro#index'
    get 'validate-users', to: 'usuarios#index'
    resources 'dashboard', only: :index
  end


end
