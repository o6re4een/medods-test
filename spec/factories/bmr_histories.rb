FactoryBot.define do
  factory :bmr_history do
    # patient { :patient }
    # formula { :formula }
    result { Faker::Number.between(from: 1, to: 100) }
    calculated_on { Faker::Date.between(from: 1.year.ago, to: Date.today) }

    association :patient
    association :formula

    before(:create) do |bmr_record|
      bmr_record.patient ||= FactoryBot.create(:patient)
      bmr_record.formula ||= create_or_return_formula
    end
  end
end
