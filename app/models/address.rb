class Address < ApplicationRecord
    has_many :users, dependent: :nullify
    
    validates :city, :state, presence: true
    validates :city, length: { maximum: 50 }
    validates :state, length: { minimum: 2, maximum: 2 }
end
