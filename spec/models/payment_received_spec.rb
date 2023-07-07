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
    payment_received = PaymentReceivedMock.call(@payment)
    user.reload
    expect(user.stripe_id).to eq("cus_test")
    expect(payment_received).to be_truthy
  end
end

class PaymentReceivedMock < PaymentReceived
  private

  def line_items
    []
  end
end