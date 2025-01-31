Rails.application.routes.draw do
  root "staticpages#top"
  get "/signup", to: "users#new" #任意のpathと対応するコントローラーのアクションを設定

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create", as: :login_to # asを設定することでlogin_toのpathを指定することができる。
  delete "/logout", to: "sessions#destroy"
 
  resources :users do         # resouresを設定することで7つのアクションとそれに対応するpathが生成される。
    member do                  # memberはresouresで生成されないアクションにidを持たせたいときに設定。
      get "block"
      get "blocked", to: "users#blocked_user"
      resource :blocks, only: [:create, :destroy]
    end
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
