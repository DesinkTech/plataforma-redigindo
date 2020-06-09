class Category < ApplicationRecord
    has_many :students
    has_many :essays
    has_many :competences

    validates :description, :max_score, presence: true
    validates :max_score, numericality: { only_integer: true }
end
