Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "prehome#index"
  get 'settings/unsubscribe'
  get '/home', to: 'home#index'
  get '/politicians', to: 'pages#politicians'
  get '/terms', to: 'pages#terms'

  namespace :admin do
    resources :tags
    resources :polls, except: [:show]
    resources :users, only: [:index, :edit, :update, :destroy] do
      collection do
        get 'permits'
      end
    end
    resources :dashboard, only: [:index]
    get '/dashboard/stats', to: 'dashboard#stats'
  end

  resources :subscriptions, only: [:create, :destroy]
  resources :users , except: [:show] do
    get 'already_voted', on: :member
    get 'validate', on: :member
    patch 'update_valid_user', on: :member
    post 'interests', to: 'interests#association', format: 'json'
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/check_session', to: 'sessions#show', format: 'json'
  delete '/sessions', to: 'sessions#destroy', as: 'session'
  delete '/destroy_facebook_session', to: 'sessions#destroy_facebook_session'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/mail_preview', to: 'messages#preview'

  get '/auth/sessions', to: 'sessions#error'
  resources :users, only: [:show]
  get '/proponents/:id', to: 'users#politician_profile', as: :politician_profile
  patch 'poll/:id', to: 'polls#toggle_status', as: :toggle_poll_status
  get 'polls/closed', to: 'polls#index_closed', format: 'json'
  get 'check_vote', to: 'votes#check_vote', format: 'json'
  get 'random_polls', to: 'polls#random_non_voted_polls', format: 'json'
  get 'summary_polls', to: 'polls#summary_polls', format: 'json'

  resources :polls do
    get 'last', on: :collection
    get 'voted', on: :collection
    get 'search', on: :collection, to: 'polls#search'
  end

  resources :votes, only: :create
  resources :tags, only: [:show, :index]
  resources :admin, only: [:create, :new, :edit]
  scope '/admin', as: :admin do
    resources :email_lists
    get '/mail', to: 'messages#new'
    post '/mail', to: 'messages#create'
    get '/mail_preview', to: 'messages#preview'
    # get '/', to: 'sessions#new'
    get '/', to: 'sessions#new', as: :login
    post '/sessions', to: 'sessions#admin_create'
    get 'validate-users', to: 'admin/users#index'
  end

  get 'settings/unsubscribe'
  get 'settings/successfully_unsubscribed'
  patch 'settings/update'

  # mount ActionCable.server => '/cable'
end