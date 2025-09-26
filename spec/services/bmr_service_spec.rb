require 'rails_helper'

RSpec.describe Patients::BmrService, type: :service do

  let!(:mifflin_formula) { create(:formula, name: "mifflin") }
  let!(:harris_formula) { create(:formula, name: "harris") }

  let(:male) { create(:gender, name: "male") }
  let(:female) { create(:gender, name: "female") }

  context "mifflin formula male check" do
    let(:patient) { create(:patient, gender: male, weight: 70.0, height: 175, birthday: 30.years.ago.to_date) }

    it "calculated mifflin value and saved to db" do
      svc = described_class.new(patient, "mifflin")

      expected_res = (10 * patient.weight) + (6.25 * patient.height) - (5 * patient.age) + 5

      expect { @result = svc.call }.to change { BmrHistory.count }.by(1)

      expect(@result).to be_within(0.5).of(expected_res)

      record = BmrHistory.order(:created_at).last
      expect(record.patient_id).to eq patient.id
      expect(record.result.to_f).to be_within(0.5).of(expected_res)
      expect(record.formula.name).to eq("mifflin")
      expect(record.calculated_on).to eq(Date.current)

    end

  end

  context "harris formula female check" do
    let(:patient) { create(:patient, gender: female, weight: 60.0, height: 165, birthday: 25.years.ago.to_date) }

    it 'calculated harris value and saved to db' do
      svc = described_class.new(patient, 'harris')
      expected = 655.1 + (9.563 * patient.weight) + (1.850 * patient.height) - (4.676 * patient.age)
      val = svc.call
      expect(val).to be_within(0.5).of(expected)

      rec = BmrHistory.order(:created_at).last
      expect(rec.formula.name).to eq('harris')
    end
  end
end