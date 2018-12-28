Rails.application.routes.draw do
  resources :animals
  resources :farms

  resources :owners

  root 'farms#index'

  get '/signin' , to: 'sessions#sign_in' ,  as: "signin"
  post '/signin' , to: 'sessions#log_in'
  delete '/signout' , to: 'sessions#sign_out' , as: "signout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
