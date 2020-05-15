Rails.application.routes.draw do

  # ユーザー管理用ルーティング nonaka
  devise_for :users
  
  # トップページ用ルーティング nonaka
  root "top#home"
  resources :home, only:[:top]
  
end