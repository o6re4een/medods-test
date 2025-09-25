class BmrHistory < ApplicationRecord
  belongs_to :patient
  belongs_to :formula

  validates :result, numericality: { greater_than_or_equal_to: 0}
  validate :calculated_on, presence: true
end
