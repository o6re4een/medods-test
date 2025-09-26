require 'rails_helper'


RSpec.describe Patient, type: :model do
  it "validates uniqueness" do
    gen = create(:gender)
    create(:patient, first_name: "A", last_name: "B", middle_name: "C", birthday: "2000-01-01", gender: gen)

    dup = build(:patient, first_name: "A", last_name: "B", middle_name: "C", birthday: "2000-01-01", gender: gen)

    expect(dup).not_to be_valid

    expect(dup.errors[:first_name]).to include('duplicate patient')

  end
end