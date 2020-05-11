Rails.application.routes.draw do
  get 'users/index'
  get 'users/signout'
  root "home#top"
end
