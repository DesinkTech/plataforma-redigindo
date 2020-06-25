class Classroom < ApplicationRecord
  belongs_to :address, optional: true
  has_many :students

  has_many_attached :files

  validates :name, presence: true
  validates :files, content_type: "application/pdf"
end
