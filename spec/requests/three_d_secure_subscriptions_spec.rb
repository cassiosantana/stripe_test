require 'rails_helper'

RSpec.describe "ThreeDSecureSubscriptions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/three_d_secure_subscriptions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/three_d_secure_subscriptions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
