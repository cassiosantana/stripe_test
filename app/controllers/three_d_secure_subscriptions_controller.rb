class ThreeDSecureSubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      subscription_data: {
        items: [{
          plan: 'pro'
        }]
      }
    )
  end

  def create
  end
end
