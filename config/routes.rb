Rails.application.routes.draw do
  root "staticpages#top"
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create", as: :login_to
  delete "/logout", to: "sessions#destroy"

  resources :users do
      member do
    get 'block'
  end
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
