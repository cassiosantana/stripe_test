require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  describe 'POST #create' do
    let(:user) { User.create(email: "teste@example.com", password: "password123") }
    let(:product) { Product.create(name: "10 vbucks", price: 3.99, quantity: 100) }

    before do
      sign_in user
    end

    context 'when creating a purchase with Stripe integration' do
      it "should redirect after creating purchase" do
        session = double("Stripe::Checkout::Session", url: "https://example.com/checkout")
        allow(Stripe::Checkout::Session).to receive(:create).and_return(session)

        post :create, params: { product_id: product.id, format: :js }

        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(session.url)
      end
    end
  end
end