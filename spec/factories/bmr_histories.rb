FactoryBot.define do
  factory :bmr_history do
    id { "" }
    patient { nil }
    formula_id { nil }
    result { "9.99" }
    calculated_on { "2025-09-25 14:20:23" }
  end
end
