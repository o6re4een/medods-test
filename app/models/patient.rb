class Patient < ApplicationRecord
  belongs_to :gender

  validates :weight, numericality: { greater_than_or_equal_to: 0 }
  validates :height, numericality: { greater_than_or_equal_to: 0 }

  validates :first_name, uniqueness: { scope: [ :last_name, :middle_name, :birthday ], message: 'duplicate patient' }

  validates :first_name, :last_name, :weight, :height, :birthday, presence: true

  has_many :doctor_patients, dependent: :destroy
  has_many :doctors, through: :doctor_patients

  has_many :bmr_histories, dependent: :destroy

  def age(_when = Date.current)
    return nil unless birthday
    age = _when.year - birthday.year
    age
  end
end
