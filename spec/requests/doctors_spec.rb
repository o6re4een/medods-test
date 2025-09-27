require 'swagger_helper'
require 'database_cleaner-active_record'

RSpec.describe 'doctors', tags: "Doctors", type: :request do
  let!(:doctors) { create_list(:doctor, 5) }

  path '/doctors' do

    get('list doctors') do
      tags "Doctor"
      parameter name: :offset, in: :query, type: :number, required: false
      parameter name: :limit, in: :query, type: :number, required: false

      response(200, 'successful') do
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

    post('create doctor') do
      let!(:doctor) { build(:doctor) }

      tags 'Doctor'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :doctor, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          middle_name: { type: :string },

        },
        required: %w[first_name last_name]
      }

      response(201, "Doctor created successfully") do

        let(:request_params) { :doctor }
        run_test!

      end
    end
  end

  path '/doctors/{id}' do

    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    let(:id) { doctors.first.id }
    get('show doctor') do
      tags 'Doctor'
      response(200, 'successful') do
        # let(:request_params) {:doctor}
        let!(:doctor) { create(:doctor) }
        let(:id) { doctor.id }

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

    put('update doctor') do
      consumes 'application/json'
      produces 'application/json'
      tags 'Doctor'

      parameter name: :doctor, in: :body, type: :object, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          middle_name: { type: :string },
        }
      }
      before do |example|
        @doctor = FactoryBot.create(:doctor)
        submit_request(example.metadata)

      end

      response(200, 'successful') do
        let(:doctor) { { :doctor => @doctor } }

        let(:id) { @doctor.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |resp|
          parsed = JSON.parse(resp.body, symbolize_names: true)
          expect(parsed[:first_name]).to eq(@doctor.first_name)
        end
      end
    end

  end
end
