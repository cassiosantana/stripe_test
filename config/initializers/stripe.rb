Stripe.api_key = ENV['STRIPE_API_KEY']

StripeEvent.signing_secret = ENV['STRIPE_WEBHOOK_KEY']

StripeEvent.configure do |config|
  config.subscribe 'checkout.session.completed' do |event|
    case event.data.object.mode
    when 'payment'
      PaymentReceived.call(event)
    when 'subscription'
      SubscribeService.call(event)
    end
  end
end