require 'rails_helper'
require 'swagger_helper'

RSpec.describe "Patients API", type: :request do

  let!(:male) { create(:gender, name: 'male') }
  let!(:female) { create(:gender, name: 'female') }
  let!(:doc1) { create(:doctor) }
  let!(:doc2) { create(:doctor) }

  describe "GET /patients (filters + pagination)" do
    before do
      create(:patient, first_name: "Ivan", last_name: "Petrov", birthday: "2000-01-01", gender: male)
      create(:patient, first_name: "Maria", last_name: "Ivanova", birthday: "2000-01-01", gender: female)
      create(:patient, :with_doctors)
    end

    it "returns list with limit and includes doctors" do
      get "/patients", params: { limit: 2 }, as: :json
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)
      expect(body.length).to be <= 2
      # проверяем, что поле doctors присутствует у первого элемента
      expect(body.first).to have_key("doctors")
    end

    it "filters by full_name (partial, any order)" do
      get "/patients", params: { full_name: "Ivan Petrov" }, as: :json
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.any? { |p| p["first_name"] == "Ivan" && p["last_name"] == "Petrov" }).to be true
    end

    it "filters by gender" do
      get "/patients", params: { gender: 'female' }, as: :json
      body = JSON.parse(response.body)
      expect(body.all? { |p| p["gender"] == 'female' || p.dig("gender","name") == 'female' }).to be true
    end
  end

  describe "POST /patients (create)" do
    it "creates patient with doctors and gender (by name)" do
      params = {
        patient: {
          first_name: "New",
          last_name: "Patient",
          birthday: "2000-01-01",
          height: 170,
          weight: 65.5,
          gender: 'male',
          doctor_ids: [doc1.id, doc2.id]
        }
      }

      post "/patients", params: params, as: :json
      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["doctors"].map { |d| d["id"] }).to match_array([doc1.id, doc2.id])
    end
  end

  describe "PUT /patients/:id (update)" do
    let!(:patient) { create(:patient, first_name: "A", last_name: "B", gender: male) }

    it "updates patient attributes and doctors" do
      put "/patients/#{patient.id}", params: { patient: { first_name: "X", doctor_ids: [doc1.id] } }, as: :json
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["first_name"]).to eq("X")
      expect(body["doctors"].map { |d| d["id"] }).to include(doc1.id)
    end
  end

  describe "DELETE /patients/:id" do
    let!(:patient) { create(:patient) }
    it "destroys patient" do
      delete "/patients/#{patient.id}", as: :json
      expect(response).to have_http_status(:no_content)
      expect { Patient.find(patient.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end


