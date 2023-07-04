class PurchasesController < ApplicationController
  before_action :authenticate_user!
  def create
    session = Stripe::Checkout::Session.create(stripe_parameters)
    redirect_to session.url, allow_other_host: true
  end

  def stripe_parameters
    {}.tap do |json|
      json[:payment_method_types] = ['card']
      json[:customer] = current_user.stripe_id if current_user.stripe_id
      json[:client_reference_id] = current_user.id unless current_user.stripe_id
      json[:customer_email] = current_user.email unless current_user.stripe_id
      json[:allow_promotion_codes] = true
      json[:line_items] = line_items
      json[:success_url] = 'http://localhost:3000/'
      json[:cancel_url] = 'http://localhost:3000/'
      json[:mode] = 'payment'
    end
  end

  def line_items
    [].tap do |array|
      products.each do |product|
        array << {
          price_data: {
            currency: 'USD',
            unit_amount: (product.price * 100).to_i,
            product_data: {
              name: product.name,
              description: product.name
            },
          },
          quantity: 1,
        }
      end
    end
  end

  def products
    Product.where(id: params[:product_id])
  end
end