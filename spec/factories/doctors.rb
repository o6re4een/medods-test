FactoryBot.define do
  factory :doctor do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.last_name}
    middle_name { Faker::Name.middle_name }
  end
end
