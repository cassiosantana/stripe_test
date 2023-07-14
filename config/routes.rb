Rails.application.routes.draw do
  resources :three_d_secure_subscriptions, only: [:new, :create]

  resources :donates, only: [] do
    collection do
      get :show
      get :thankyou
    end
  end

  resource :purchases, only: :create

  # mount StripeEvent::Engine, at: '/stripe/webhook'
  post "/stripe/webhook", to: "stripe_webhooks#event"

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
