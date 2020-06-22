class CorrectionCompetence < ApplicationRecord
  before_validation :negative

  belongs_to :correction
  belongs_to :competence

  validates :correction, :competence, :penalty, presence: true
  validates :penalty, numericality: { only_integer: true, less_than_or_equal_to: 0, greater_than_or_equal_to: -1000 }

  private

  def negative
    self.penalty = -self.penalty unless self.penalty < 0
  end

end
