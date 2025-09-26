require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Patients::BmiService, type: :service do

  let(:gender) {create( :gender, name: 'male' )}
  let(:patient) {create(:patient, weight: 54.44,height: 180, gender: gender)}


  it 'BMI integration check' do
    expected_url = Patients::BmiService::API_URL + "/#{patient.weight}" + "/#{(patient.height.to_f/100)}"

    stub_request(:get, expected_url)
      .to_return(
        status: 200,
        body: {bmi: 22.5, category: "Normal"}.to_json,
        headers: {'Content-Type' => 'application/json'}
      )

    svc = described_class.new(patient)
    res = svc.call

    expect(res).to be_a(Hash)
    expect(res["bmi"]).to eq 22.5
    expect(res['category']).to eq 'Normal'

    expect(a_request(:get, expected_url)).to have_been_made.once
  end
end