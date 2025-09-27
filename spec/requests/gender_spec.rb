require 'swagger_helper'

RSpec.describe 'gender', type: :request do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end
  path '/gender' do

    get('list genders') do
      let!(:genders) { create_list(:gender, 1) }
      response(200, 'successful') do

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

    post('create gender') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :request_params, in: :body, schema: {
        type: :object,
        properties: {
          gender: { type: :string },
        },
        description: "gender ex: Male"
      }

      response(200, 'successful') do
        let(:test_gender) { create(:gender, name: 'male test') }
        let(:request_params) { { gender: test_gender.name } }

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
  end

end
