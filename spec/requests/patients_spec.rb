require 'swagger_helper'

RSpec.describe 'Patients API', type: :request do

  path '/patients' do

    get('list patients') do
      produces "application/json"
      consumes "application/json"

      parameter name: :full_name, in: :query, type: :string
      parameter name: :gender, in: :query, type: :string
      parameter name: :offset, in: :query, type: :integer
      parameter name: :limit, in: :query, type: :integer
      # let!(:gender) { create(:gender, name: 'male') }

      response(200, 'successful') do

        tags 'Patients'
        let!(:patients) { create_list(:patient, 1, :with_doctors) }

        let(:full_name) { patients[0].first_name }
        let(:gender) { patients[0].gender.name }
        let(:offset) { 0 }
        let(:limit) { 10 }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
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
            required: %w[first_name last_name birthday height weight gender]
          }
        }
      }

      response '201', 'created' do
        let!(:gender) { create(:gender, name: "male") }
        let(:patient) { { patient: { first_name: 'A', last_name: 'B', birthday: '1990-01-01', height: 170, weight: 70.5, gender: 'male', doctor_ids: [] } } }
        run_test!
      end
    end
  end

  path '/patients/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id', required: true

    get('show patient') do
      tags 'Patients'
      response(200, 'successful') do
        let!(:patient) { create(:patient) }
        let(:id) { patient.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update patient') do
      tags 'Patients'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :patient, in: :body, description: 'patient', shema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          middle_name: { type: :string },
          birthday: { type: :string, format: :date },
          height: { type: :number },
          weight: { type: :number },
          gender: { type: :string },
          doctor_ids: { type: :array, items: { type: :integer } }

        }
      }
      before do |example|
        @patient = FactoryBot.create(:patient)
        submit_request(example.metadata)
      end

      response(200, 'successful') do
        let(:patient) do
          {
            first_name: 'Иван',
            last_name: 'Петров',
            birthday: '1990-01-01',
            height: 180,
            weight: 75.0,
            gender: 'male',
            doctor_ids: []
          }
        end
        let(:id) { @patient.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    # delete('delete patient') do
    #   tags 'Patients'
    #   response(200, 'successful') do
    #     let(:id) { '123' }
    #
    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end
end
