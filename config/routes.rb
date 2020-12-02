Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"
  
  post "/login", to: "sessions#create"

  get '/dashboard', to: 'users#show'

  get '/discover', to: 'movies#search'
end
