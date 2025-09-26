FactoryBot.define do
  factory :formula do
    sequence(:name) { |n| ["mifflin","harris"][n % 2] }
  end
end
