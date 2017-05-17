Rails.application.routes.draw do
  root 'intro#inicio'

  resources :photos, only: :create

  resources :users , except: [:new, :show] do
    get 'already_voted', on: :member
    get 'validate', on: :member
    patch 'update_valid_user', on: :member
    resources :interests, exclude: [:new, :edit], format: 'json'
    resources :tags, only: :index, to: 'tags#user_interests', format: 'json'
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  post '/sessions', to: 'sessions#create', format: 'json'

  get '/auth/sessions', to: 'sessions#error'

  patch 'debate/:id', to: 'debates#publish', as: :publish_debate
  patch 'poll/:id', to: 'polls#toggle_status', as: :toggle_poll_status

  resources :polls do
    get 'last', on: :collection
    get 'voted', on: :collection
    resources :debates, on: :collection
    get '/debates/:id/change_debate_state', to: 'debates#change_debate_state', as: :change_debate_state
  end

  resources :tipo_de_documentos, only: :index
  resources :votes, only: :create
  resources :debate_votes, only: :create
  get '/tags', to: 'tags#index'
  resources :admin, only: [:create, :new]
  scope '/admin', as: :admin do
    # get '/', to: 'sessions#new'
    post '/tags', to: 'tags#create'
    get '/tags/new', to: 'tags#new'
    delete '/tags/:id', to: 'tags#delete'
    get '/tags/:id', to: 'tags#edit', as: :tag
    patch '/tags/:id', to: 'tags#update'
    get 'polls', to:  'polls#index_admin'
    get '/', to: 'sessions#new', as: :login
    post '/sessions', to: 'sessions#admin_create'
    get 'validate-users', to: 'users#index'
    resources 'dashboard', only: :index
  end

  mount ActionCable.server => '/cable'
end
