Rails.application.routes.draw do
  root 'intro#inicio'

  resources :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # :omniauth_callbacks "users/omniauth_callbacks"
end
