Rails.application.routes.draw do
  get 'home/top'
  root "tests#index"
end
