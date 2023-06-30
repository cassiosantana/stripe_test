class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stripe_customer
    return Stripe::Customer.retrieve(stripe_id) if stripe_id?
    stripe_customer = Stripe::Customer.create(email: email,
    payment_method: 'pm_card_visa',
      invoice_settings: {
      default_payment_method: 'pm_card_visa'
    })
    update(stripe_id: stripe_customer.id)
    stripe_customer
  end

  def subscribed?
    stripe_subscription_id?
  end
end
