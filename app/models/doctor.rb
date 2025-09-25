class Doctor < ApplicationRecord


  has_many :doctor_patients, dependent: :destroy
  has_many :patients, through: :doctor_patients
end
