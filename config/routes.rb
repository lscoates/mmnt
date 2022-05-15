Rails.application.routes.draw do
  root 'tracks#index'

  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  resources :tracks, only: [:index, :show, :new, :create] do
    resources :moments, only: [:new, :create, :edit, :update]
  end
end
