Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get "/signup", to: "users#new"
  resources :users do
    get '/followers', to: "users#followers"
    get '/following', to: "users#followees"
    get 'credits'
    member do
      get :confirm_email
    end
  end
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  
  resources :password_resets
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, param: :published_token do
    resources :answers do
      resources :comments
    end
    resources :comments
    collection do
      match "search" => "questions#search", via: [:get, :post], as: :search
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
