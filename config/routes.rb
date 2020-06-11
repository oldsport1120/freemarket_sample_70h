Rails.application.routes.draw do
  # deviseのルーティングが先に読み取られる必要があるので、通常のルーティング追記は下部に追加でお願いします。nonaka
  # ユーザー管理用ルーティング nonaka
  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  # トップページ用ルーティング nonaka
  # root "home#top"
  # resources :home, only:[:top]
  root "products#index"

  # マイページ用のルーティング ito
  get 'users/index'
  get 'users/signout'
  get 'users/card'

  # buyアクションを追加 matsumoto
  # indexアクションを追加 murakami
  resources :products, only: [:index,:show, :new, :create] do
    member do
      get "buy"
    end
  end

end 
