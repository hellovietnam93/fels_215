Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy" 
  resources :users, except: [:edit, :update, :destroy]
  namespace :admin do
    root "dashboard#index", as: :home
    resources :categories
  end
end
