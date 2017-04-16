Rails.application.routes.draw do
  get 'rankings/index'

  root 'rankings#index'
end
