class CorrectionComment < ApplicationRecord
  belongs_to :correction
  belongs_to :comment, optional: true

  # validates :correction, :comment, presence: true
  validates :correction, :label_id, :label_coords, presence: true
  validates :extended_comment, allow_nil: true, presence: false 

end
