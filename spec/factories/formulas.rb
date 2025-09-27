FactoryBot.define do
  factory :formula do
    sequence(:name) { |n| [ "mifflin", "harris" ][n % 2] }

  end

  def create_or_return_formula
    @formula ||= FactoryBot.create(:formula)
  end
end
