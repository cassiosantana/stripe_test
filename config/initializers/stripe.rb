Stripe.api_key = ENV['STRIPE_API_KEY']

StripeEvent.signing_secret = ENV['STRIPE_WEBHOOK_KEY']

StripeEvent.configure do |config|
  config.subscribe 'checkout.session.completed' do |event|
    if event.data.object.mode == "payment"
      PaymentReceived.call(event)
    elsif event.data.object.mode == "subscription"
      SubscribeService.call(event)
    end
  end
end