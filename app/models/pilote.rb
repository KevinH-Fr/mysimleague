class Pilote < ApplicationRecord
   
   belongs_to :event, optional: true

   #has_and_belongs_to_many :divisions

   has_many :divisions
   #scope :in_division, -> (division_id) { joins(:divisions_pilotes).where("divisions_pilotes.division_id = ?", division_id) }

   validates :nom, presence: true

   #scope :division_courante, -> { includes(:pilotes) }

  # scope :division_courante, -> (division_courante) { where("saison_id = ?", division_courante)}

   def feed_content
      nom
   end 

end
