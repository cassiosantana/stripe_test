require 'rails_helper'

RSpec.describe PaymentReceived, type: :model do
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
    allow_any_instance_of(PaymentReceived).to receive(:line_items).and_return([])
    payment_received =  PaymentReceived.new(@payment).call
    user.reload
    expect(user.stripe_id).to eq("cus_test")
    expect(payment_received).to eq(true)
  end
end
