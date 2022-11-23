class Production < ApplicationRecord
    has_many :crew_members

    validates :title, presence: true
end
