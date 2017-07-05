Rails.application.routes.draw do
  
  root to: 'visitors#index'
  devise_for :users
  resources :users do 
    resources :lists do
      resource :vote , module: :lists
      resource :listproducts , only: [:create, :destroy]
    end
  end
 # post 'sku/',    to: 'sku#find', as: 'sku_find'
  get  'sku/:id', to: 'sku#show', as: 'sku_show'

 # Followers - Followees Relationships 
  resources :users do
    member do
      get :followees, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]


end
