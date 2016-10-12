Rails.application.routes.draw do
  root 'intro#inicio'

  resources :usuarios, only: [:new, :create]

  #ToDo ajax call on session
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/sessions', to: 'sessions#create', format: 'json'
  get '/auth/sessions', to: 'sessions#error'

  resources :polls, except: [:destroy, :update]
  resources :tipo_de_documentos, only: :index

  scope '/votes', controller: :votes do
    post '/yes', action: :yes
    post '/no', action: :no
    post '/blank', action: :blank
  end

end
