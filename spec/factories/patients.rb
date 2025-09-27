FactoryBot.define do
  factory :patient do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::Name.middle_name }
    birthday { Faker::Date.birthday }
    height { Faker::Number.between(from: 50, to: 210) }
    weight { Faker::Number.between(from: 5.0, to: 299.0) }

    association :gender
    #
    before(:create) do |patient|
      patient.gender ||= create_or_return_gender

    end

    trait :with_doctors do
      after(:create) do |patient|
        create_list(:doctor, 2).each { |d| patient.doctors << d }
      end
    end

  end
end


