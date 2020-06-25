class Student < ApplicationRecord
  after_create :create_registration_number

  has_many :corrections, dependent: :destroy
  has_many :essays, dependent: :destroy
  belongs_to :user, dependent: :destroy
  belongs_to :category
  belongs_to :school
  belongs_to :classroom

  accepts_nested_attributes_for :user

  validates :user, :school, :category, :classroom, presence: true
  validates :registration_number, length: { maximum: 10 }
  validates :credits, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def refill_credits(amount)
    self.credits += amount unless amount == 0
  end

  # private

  def create_registration_number
    self.registration_number = (Date.current.year.to_s +
                               ((sprintf "%03d", self.classroom.id).to_s) +
                               (sprintf "%03d", self.id).to_s).to_s

    self.save
  end
end
