class Theme < ApplicationRecord
  before_save :fill_hash_id
  has_many :essays

  validates :description, presence: true

  private

  def fill_hash_id
    self.hash_id = SecureRandom.alphanumeric(37)
  end
end
