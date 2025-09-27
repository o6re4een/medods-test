require 'swagger_helper'

RSpec.describe 'bmi', type: :request do

  before(:all) do
    WebMock.allow_net_connect!
  end

  after(:all) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  path '/bmi' do

    get('calculate bmi') do

      parameter name: :id, type: 'integer', required: true, description: 'Patient ID', in: :query
      let!(:patient) { create(:patient) }
      response(200, 'successful') do

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
  end
end
