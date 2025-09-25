require 'rails_helper'

RSpec.describe "Bmis", type: :request do
  describe "GET /calculate" do
    it "returns http success" do
      get "/bmi/calculate"
      expect(response).to have_http_status(:success)
    end
  end

end
