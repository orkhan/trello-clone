Rails.application.routes.draw do

  root to: 'home#index'
  
  resources :boards, only: [:show, :create] do
    resources :lists, only: [:show, :create, :destroy]
  end

  resources :cards, only: [:show, :create, :update, :destroy, :move]
end
