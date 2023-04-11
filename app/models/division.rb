class Division < ApplicationRecord

    belongs_to :saison
    has_many :events

    #scope :saison_courante, -> (saison_courante) { where("saison_id = ?", saison_courante)}

    def feed_content
        nom
     end 
end
