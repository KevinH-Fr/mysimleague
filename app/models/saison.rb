class Saison < ApplicationRecord

    belongs_to :ligue
    has_many :divisions

    scope :ligue_courante, -> (ligue_courante) { where("ligue_id = ?", ligue_courante)}

    def feed_content
        nom
     end 
end
