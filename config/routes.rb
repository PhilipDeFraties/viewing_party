Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"

  namespace :user do
    get '/dashboard', to: 'dashboard#show'
  end

  post "/login", to: "sessions#create"
end
