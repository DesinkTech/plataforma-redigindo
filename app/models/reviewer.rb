class Reviewer < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :corrections

  accepts_nested_attributes_for :user

  validates :user, :reviewed, presence: true
end
