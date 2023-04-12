class Division < ApplicationRecord

    belongs_to :saison

    has_many :events

   # has_many :pilotes
    #has_and_belongs_to_many :pilotes

    has_many :participations
    has_many :pilotes, through: :participations
  
    scope :saison_courante, -> (saison_courante) { where("saison_id = ?", saison_courante)}

    def feed_content
        nom
     end 

end
