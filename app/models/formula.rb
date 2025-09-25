class Formula < ApplicationRecord
  has_many :bmr_histories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
