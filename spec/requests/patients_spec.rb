require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/patients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/patients/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/patients/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/patients/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/patients/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
