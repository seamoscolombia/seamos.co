Rails.application.routes.draw do
  root 'frontend#index'
  # root 'intro#inicio'

  resources :photos, only: :create

  get 'admin_homepage', to: 'intro#inicio', as: 'admin_homepage'
  resources :users , except: [:show] do
    get 'already_voted', on: :member
    get 'validate', on: :member
    patch 'update_valid_user', on: :member
    post 'interests', to: 'interests#association', format: 'json'
    resources :tags, only: :index, to: 'tags#user_interests', format: 'json'
  end


  get 'client/polls/:id', to: 'polls#client_show'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/check_session', to: 'sessions#show', format: 'json'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  delete '/destroy_facebook_session', to: 'sessions#destroy_facebook_session'
  post '/sessions', to: 'sessions#create', format: 'json'

  get '/auth/sessions', to: 'sessions#error'
  get '/tags/:tag_id/polls', to: 'polls#filtered_by_tag', format: 'json'
  get '/politician/:politician_id/polls', to: 'polls#filtered_by_politician', format: 'json'
  get '/profile', to: 'users#show', format: 'json'
  get '/proponents/:id', to: 'users#politician_profile', format: 'json'
  patch 'debate/:id', to: 'debates#publish', as: :publish_debate
  patch 'poll/:id', to: 'polls#toggle_status', as: :toggle_poll_status
  get 'polls/closed', to: 'polls#index_closed', format: 'json'
  get 'check_vote', to: 'votes#check_vote', format: 'json'
  get 'random_polls', to: 'polls#random_non_voted_polls', format: 'json'
  get 'summary_polls', to: 'polls#summary_polls', format: 'json'

  resources :polls do
    get 'last', on: :collection
    get 'voted', on: :collection
    get 'search', on: :collection, to: 'polls#search'
    resources :debates, on: :collection
    get '/debates/:id/change_debate_state', to: 'debates#change_debate_state', as: :change_debate_state
  end

  resources :tipo_de_documentos, only: :index
  resources :votes, only: :create
  resources :debate_votes, only: :create
  get '/tags', to: 'tags#index'
  resources :admin, only: [:create, :new, :edit]
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
    resources 'dashboard', only: [:index]
    get '/dashboard/stats', to: 'dashboard#stats'
  end

  # mount ActionCable.server => '/cable'
end
