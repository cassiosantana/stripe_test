require 'rails_helper'

RSpec.describe PaymentReceived, type: :model do
  let!(:product) { Product.create(name: "10 vbucks", price: 9.99, quantity: 10) }
  let(:user) { User.create(email: "teste@example.com", password: "pass_123") }

  before do
    json = {
      data: {
        object: {
          id: "cs_test_id",
          amount_subtotal: 399,
          amount_total: 399,
          client_reference_id: user.id,
          customer: "cus_test",
        }
      }
    }.to_json

    @payment = JSON.parse(json, object_class: OpenStruct)
  end

  it "should credit user vbucks" do
    expect(user.vbuck.to_i).to eq(0)
    allow_any_instance_of(PaymentReceived).to receive(:line_items).and_return(
      [
         OpenStruct.new(description: '10 vbucks', quantity: 1),
         OpenStruct.new(description: '10 vbucks', quantity: 1)
      ]
    )
    payment_received =  PaymentReceived.new(@payment).call
    user.reload
    expect(user.stripe_id).to eq("cus_test")
    expect(payment_received).to eq(true)
    expect(user.vbuck).to eq(20)
  end
end
