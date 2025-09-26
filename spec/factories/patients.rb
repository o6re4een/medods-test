
FactoryBot.define do
  factory :patient do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.last_name}
    middle_name { Faker::Name.middle_name }
    birthday {Faker::Date.birthday}
    height { Faker::Number.between(from: 130, to: 210) }
    weight {Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    association :gender

    trait :with_doctors do
      after(:create) do |patient|
        create_list(:doctor, 2).each {|d| patient.doctors << d }
      end
    end
  end
end


