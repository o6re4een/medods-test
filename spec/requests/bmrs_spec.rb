require 'rails_helper'

RSpec.describe "Bmrs", type: :request do
  describe "GET /history" do
    it "returns http success" do
      get "/bmr/history"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /calculate" do
    it "returns http success" do
      get "/bmr/calculate"
      expect(response).to have_http_status(:success)
    end
  end

end
