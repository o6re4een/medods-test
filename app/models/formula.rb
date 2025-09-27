class Formula < ApplicationRecord
  has_many :bmr_histories, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :name, message: "Formula already exists" }
end
