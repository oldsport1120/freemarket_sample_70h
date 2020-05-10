Rails.application.routes.draw do
  get 'users/index'
  root "home#top"
end
