FactoryBot.define do
  factory :gender do
    name {Faker::Gender.type}

  end
end
