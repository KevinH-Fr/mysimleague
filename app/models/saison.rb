class Saison < ApplicationRecord

    scope :ligue_courante, -> (ligue_courante) { where("ligue_id = ?", ligue_courante)}

    def feed_content
        nom
     end 
end
