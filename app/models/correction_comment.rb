class CorrectionComment < ApplicationRecord
  before_validation :negative
  before_save :discount_score
  before_destroy :refund_score

  belongs_to :correction
  belongs_to :comment

  validates :correction, :comment, :essay_line, :text_cut, :penalty, presence: true
  validates :essay_line, numericality: { only_integer: true, less_than_or_equal_to: 30, greater_than_or_equal_to: 0 }
  validates :penalty, numericality: { only_integer: true, less_than_or_equal_to: 0, greater_than_or_equal_to: -200 }

  private

  def negative
    self.penalty = -self.penalty unless self.penalty < 0
  end

  def discount_score
    unless self.penalty == 0
      cc = self.correction.correction_competences.select { |cc| cc.competence_id == self.comment.competence.id }.pop
      
      if self.penalty % cc.competence.penalty_division != 0
        self.errors.add(:base, "Penalidade inválida!")
        throw :abort
      end

      cc.penalty += self.penalty

      unless cc.penalty < cc.competence.max_penalty
        self.correction.final_score += cc.penalty
        cc.save
        self.correction.save
      else
        self.errors.add(:base, "O comentário excede a penalidade máxima por competência!")
        throw :abort
      end
    end
  end

  def refund_score
    unless self.penalty == 0
      cc = self.correction.correction_competences.select { |cc| cc.competence_id == self.comment.competence.id }.pop

      self.correction.final_score -= cc.penalty
      cc.penalty -= self.penalty
      cc.save
      self.correction.save
    end
  end
end
