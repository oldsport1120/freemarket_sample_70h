Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
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

  # resources :products, only: [:show, :buy, :new,]
  # buyアクションを追加 matsumoto
  # destroyアクションを追加 comments/create アクションをネストで追加 nonaka
  resources :products, only: [:index, :show, :new, :create, :destroy, :edit] do
    resources :comments, only: :create
    member do
      get "buy"
      get "pay"
    end
  end


  resources :cards, only: [:index, :new, :create, :show, :destroy] do
    member do
      get "buy"
      get "pay"
    end

  end
  resources :users, only: :show


  #カテゴリー用のルーティング simizu
  resources :categorys, only: [:index, :show, :new, :edit, :destroy] do
    collection do # 新規用（new) usr:categorys/newのため
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do # 編集(edit用) usl: categorys/id/editのため
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

end 
