class Gender < ApplicationRecord

  has_many :patients
  validates :name, presence: true, uniqueness: { scope: :name, message: "Gender #{:name} already exists" }

end
