Rails.application.routes.draw do
  
  # ユーザー管理用ルーティング nonaka
  devise_for :users
  
  # トップページ用ルーティング nonaka
  root "home#top"
  resources :home, only:[:top]

  # マイページ用のルーティング　ito
  get 'users/index'
  get 'users/signout'
  get 'users/card'
  
end 