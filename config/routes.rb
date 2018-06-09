Rails.application.routes.draw do
  
  resources :boards, only: [:show, :create] do
    resources :lists, only: [:create, :destroy]
  end

  resources :cards, only: [:create, :update, :destroy, :move]
end
