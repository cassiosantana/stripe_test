class PaymentReceived
  def self.call(event)
    new(event).call
  end

  attr_reader :event
  def initialize(event)
    @event = event
  end

  def call
    return false unless user
    user.update(stripe_id: object.customer) unless user.stripe_id
    complete_purchase
    true
  end

  private

  def user
    @user ||= if object.client_reference_id
                User.find_by(id: object.client_reference_id)
              else
                User.find_by(stripe_id: object.customer)
              end
  end

  def object
    @object ||= event.data.object
  end

  def complete_purchase
    line_items.each do |item|
      product = Product.find_by(name: item.description)
      total = product.quantity * item.quantity
      user.update(vbuck: user.vbuck.to_i + total)
    end
  end

  def line_items
    Stripe::Checkout::Session.list_line_items(object.id).data
  end
end