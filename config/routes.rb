Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :edit, :update, :show]
  root to: 'sessions#new'
  resources :pictures do
    collection do
      post :confirm
    end
  end
end