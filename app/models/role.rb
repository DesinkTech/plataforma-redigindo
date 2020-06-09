class Role < ApplicationRecord
    has_many :users

    validates :description, presence: true
end
