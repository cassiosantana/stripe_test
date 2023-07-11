class DonatesController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create(
      billing_address_collection: :auto,
      mode: :payment,
      payment_method_types: ["card"],
      line_items: [
        {
          price_data: {
            unit_amount: params[:amount],
            currency: "USD",
            product_data: {
              name: "Donation",
              description: "donation"
            },
          },
          quantity: 1,
        }
      ],
      success_url: "http://localhost:3000/donates/thankyou",
      cancel_url: "http://localhost:3000"
    )

    redirect_to session.url, allow_other_host: true
  end

  def thankyou
  end
end
