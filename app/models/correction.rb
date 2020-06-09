class Correction < ApplicationRecord
  before_create :fill_hash_id, :fill_final_score, :fill_competences
  before_validation :fill_start_date

  belongs_to :student
  belongs_to :essay, dependent: :destroy
  belongs_to :reviewer, optional: true
  belongs_to :admin, optional: true

  has_many :correction_comments
  has_many :comments, through: :correction_comments

  has_many :correction_competences, dependent: :destroy
  has_many :competences, through: :correction_competences

  accepts_nested_attributes_for :correction_comments

  validates :start_date, :final_score, :student, :essay, presence: true

  private

  def fill_hash_id
    self.hash_id = SecureRandom.alphanumeric(32)
  end

  def fill_start_date
    self.start_date = DateTime.current
  end

  def fill_final_score
    self.final_score = self.essay.category.max_score unless not self.valid_essay
  end

  def fill_competences
    self.competences = self.essay.category.competences
  end
end
