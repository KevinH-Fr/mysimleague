class Circuit < ApplicationRecord
    has_many :events

    has_one_attached :drapeau
    has_one_attached :carte

    def nom_complet
      "#{nom} #{pays}"
    end 


    def feed_content
      nom
    end 
end
