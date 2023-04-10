class Circuit < ApplicationRecord
    has_many :events

    def nom_complet
      "#{nom} #{pays}"
    end 

    def feed_content
      nom
    end 
end
