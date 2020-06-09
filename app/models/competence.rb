class Competence < ApplicationRecord
  before_validation :negative

  belongs_to :category

  has_many :comments

  has_many :correction_competences
  has_many :corrections, through: :correction_competences

  validates :description, :max_penalty, :penalty_division, presence: true
  validates :penalty_division, numericality: { only_integer: true }
  validates :max_penalty, numericality: { only_integer: true, less_than_or_equal_to: 0, greater_than_or_equal_to: -1000 }

  private

  def negative
    self.max_penalty = -self.max_penalty unless self.max_penalty < 0
  end
end
