require 'swagger_helper'
RSpec.describe 'Patients API DOCS', type: :request do
  path '/patients' do
    get 'List patients' do
      tags 'Patients'
      produces 'application/json'
      parameter name: :limit, in: :query, schema: { type: :integer }

      response '200', 'ok' do
        let!(:patient) { create(:patient, :with_doctors) }

        let(:limit) { 10 }
        run_test!
      end
    end

    post 'Create patient' do
      tags 'Patients'
      consumes 'application/json'
      parameter name: :patient, in: :body, schema: {
        type: :object,
        properties: {
          patient: {
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              birthday: { type: :string, format: :date },
              height: { type: :number },
              weight: { type: :number },
              gender: { type: :string },
              doctor_ids: { type: :array, items: { type: :integer } }
            },
            required: %w[first_name last_name birthday height weight]
          }
        }
      }

      response '201', 'created' do
        let!(:gender) {create(:gender, name: "male")}
        let(:patient) { { patient: { first_name: 'A', last_name: 'B', birthday: '1990-01-01', height: 170, weight: 70.5, gender: 'male', doctor_ids: [] } } }
        run_test!
      end
    end
  end
end