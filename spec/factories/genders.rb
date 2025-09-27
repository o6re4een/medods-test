FactoryBot.define do
  factory :gender do
    name { Faker::Gender.binary_type }

  end

  def create_or_return_gender
    @gender ||= FactoryBot.create(:gender)
  end
end
