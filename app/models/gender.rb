class Gender < ApplicationRecord

  has_many :patients
  validates :name, presence: true, uniqueness: true

end
