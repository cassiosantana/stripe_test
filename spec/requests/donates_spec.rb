require 'rails_helper'

RSpec.describe "Donates", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/donates/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /thankyou" do
    it "returns http success" do
      get "/donates/thankyou"
      expect(response).to have_http_status(:success)
    end
  end

end
