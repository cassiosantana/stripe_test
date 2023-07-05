# controllers/subscriptions/resubscribes_controller.rb
module Subscriptions
  class ResubscribesController < ApplicationController

    def new
      subscription = Stripe::Subscription.list(customer: current_user.stripe_id).first
      if subscription.save
        current_user.update(stripe_subscription_id: subscription.id, expires_at: nil)
        flash.notice = "Thanks for resubscribing!"
      else
        flash.alert = "There was a problem resubscribing!"
      end
      redirect_to root_path
    end
  end
end