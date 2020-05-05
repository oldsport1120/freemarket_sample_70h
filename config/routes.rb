Rails.application.routes.draw do
  get 'tests/index'
  root "tests#index"
end
