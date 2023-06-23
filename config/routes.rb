Rails.application.routes.draw do
  resource :purchases, only: :create
  mount StripeEvent::Engine, at: '/stripe/webhook'
  resources :products
  devise_for :users
  resources :subscriptions, only: [:new, :create]
  root to: 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
