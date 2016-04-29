Rails.application.routes.draw do

  root to: "users#new"

  resource :session, only: [:create, :destroy, :new]
  resources :users, only: [:create, :new, :show]
  resources :redemption_cards, only: [:create, :new, :show, :index] do
    collection do
      get 'check_form'
      post 'check'
    end
  end
end
