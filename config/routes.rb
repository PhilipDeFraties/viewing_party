Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"

  post "/login", to: "sessions#create"

  namespace :user do
    get '/dashboard', to: 'dashboard#show'
  end

  get '/discover', to: 'discover#index'

  
   get 'movies/top40', to: 'movies#top40'
   get 'movies/search', to: 'movies#search'
   get 'movies/results', to: 'movies#search_results'
   resources :movies, only: %i[show]

  
  post '/friendship/create', to: 'friendships#create'
end
