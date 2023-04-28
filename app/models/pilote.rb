class Pilote < ApplicationRecord
   
  belongs_to :event, optional: true

  has_many :participations
  has_many :divisions, through: :participations
  has_many :resultats
  
   validates :nom, presence: true

   def feed_content
      nom
   end 

end
