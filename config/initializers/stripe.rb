Stripe.api_key = Rails.application.credentials.stripe_private_key

# Stripe.api_key = ENV['STRIPE_API_KEY']
StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

StripeEvent.configure do |config|
  config.subscribe 'checkout.session.completed' do |event|
    PaymentReceived.call(event)
  end
end