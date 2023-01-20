Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get "/signup", to: "users#new"
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :password_resets
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, param: :published_token do
    collection do
      match 'search' => 'questions#search', via: [:get, :post], as: :search
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
