Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"

  post "/login", to: "sessions#create"

  namespace :user do 
    get '/dashboard', to: 'dashboard#show'
  end 

  get '/discover', to: 'movies#search'

  post '/friendship/create', to: 'friendships#create'
end
