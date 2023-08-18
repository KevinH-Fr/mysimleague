class Circuit < ApplicationRecord

    validates :nom, presence: true
    has_one_attached :drapeau

    def feed_content
        id
    end 

    def self.ransackable_attributes(auth_object = nil)
        ["carte", "created_at", "id", "latitude", "longitude", "nom", "pays", "updated_at"]
    end
end
