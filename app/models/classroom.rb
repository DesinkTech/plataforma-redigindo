class Classroom < ApplicationRecord
  belongs_to :address, optional: true
  has_many :students

  validates :name, presence: true
end
