class Theme < ApplicationRecord
  before_create :fill_hash_id
  
  belongs_to :category
  has_many :essays

  has_one_attached :support_material
  
  validates :description, :category_id, presence: true
  validates :support_material, content_type: 'application/pdf'

  private

  def fill_hash_id
    self.hash_id = SecureRandom.alphanumeric(37)
  end
end
