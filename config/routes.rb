Rails.application.routes.draw do
  get 'users/index'
  get 'users/signout'
  get 'users/card'
  root "home#top"
end
