Rails.application.routes.draw do
  get 'donates/create'
  get 'donates/thankyou'
  resource :purchases, only: :create
  mount StripeEvent::Engine, at: '/stripe/webhook'
  resources :products
  devise_for :users
  resources :subscriptions, only: [:new, :create] do
    scope module: 'subscriptions' do
      collection do
        resource :unsubscribe, only: :destroy
        resource :resubscribe, only: :new
      end
    end
  end
  root to: 'home#index'
  get '/example', to: 'home#example'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
