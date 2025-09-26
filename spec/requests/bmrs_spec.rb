require 'swagger_helper'

RSpec.describe 'bmrs', type: :request do
  path '/bmr' do
    post('calculate bmr') do
      tags 'BMR'
      parameter name: :calc_params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          formula: { type: :string, example: 'mifflin', description: "Formula name lowercase" },
          id: { type: :integer, example: 1, description: "Patient Id" }

        }
      }

      consumes 'application/json'
      produces 'application/json'


      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 formula: { type: :string }
               }
        let!(:patient) { create(:patient) }
        let!(:formula_name) { create(:formula).name }

        let(:calc_params) { { "formula" => formula_name, "id" => patient.id } }


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

    get('history bmr') do
      tags 'BMR'

      let!(:bmr_history) { create_list(:bmr_history, 3) }
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
  end
end
