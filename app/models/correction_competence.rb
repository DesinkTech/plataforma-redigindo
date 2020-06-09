class CorrectionCompetence < ApplicationRecord
  belongs_to :correction
  belongs_to :competence

  accepts_nested_attributes_for :competence
  
  validates :correction, :competence, :penalty, presence: true
  validates :penalty, numericality: { only_integer: true, less_than_or_equal_to: 0, greater_than_or_equal_to: -1000 }
end
