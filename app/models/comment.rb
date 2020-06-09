class Comment < ApplicationRecord
  belongs_to :competence
  
  has_many :correction_comments
  has_many :corrections, through: :correction_comments
  
  validates :description, presence: true
  validates :competence, presence: true, allow_nil: true
end
