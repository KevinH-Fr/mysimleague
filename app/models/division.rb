class Division < ApplicationRecord

    belongs_to :saison, optional: true

    has_many :events, dependent: :delete_all

    has_many :participations
    has_many :pilotes, through: :participations
  
    def feed_content
        nom
     end 

end
