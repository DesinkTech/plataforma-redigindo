class Essay < ApplicationRecord
  before_validation :fill_submission_date, :fill_hash_id
  
  belongs_to :student
  belongs_to :theme
  belongs_to :category

  has_one :correction

  has_one_attached :file

  validates :hash_id, :submission_date, :theme, :student, :category, presence: true
  validates :file, attached: true, content_type: ['image/png','image/jpeg','image/jpg']

  private

  def fill_submission_date
    self.submission_date = Date.current
  end

  def fill_hash_id
    self.hash_id = SecureRandom.alphanumeric(32)
  end
  
end
