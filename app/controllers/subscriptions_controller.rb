class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    customer = current_user.stripe_customer
    begin
      subscription = Stripe::Subscription.create({
                                             customer: customer.id,
                                             items: [{plan: "plan_OB8cm9kBaZcPCb"}],
                                             payment_settings: {payment_method_types: ['card']}
                                           })
      current_user.assign_attributes(stripe_subscription_id: subscription.id)
      current_user.save
      redirect_to root_path, notice: 'Thanks for subscribing!'
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new
    end
  end
end
