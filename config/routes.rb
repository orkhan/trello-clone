Rails.application.routes.draw do

  root to: 'home#index'
  
  resources :boards, only: [:show, :create]
  resources :lists, only: [:show, :create, :destroy]
  resources :cards, only: [:show, :create, :update, :destroy, :move]
end
