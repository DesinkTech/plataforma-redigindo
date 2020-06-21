class CorrectionComment < ApplicationRecord
  belongs_to :correction
  belongs_to :comment

  validates :correction, :comment, presence: true
  validates :extended_comment, allow_nil: true, presence: false 

end
