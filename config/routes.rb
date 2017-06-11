Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  post 'sku/',    to: 'sku#find', as: 'sku_find'
  get  'sku/:id', to: 'sku#show', as: 'sku_show'
end
