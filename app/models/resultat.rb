class Resultat < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :pilote, optional: true
  belongs_to :equipe, optional: true

#  scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}

 # scope :division_courante, -> (division_courante) { joins(:event).where("division_id = ?", division_courante)}
 # scope :numero_courant_et_inferieurs, -> (eventNum) { joins(:event).where("numero <= ?", eventNum)}

  def feed_content
    id
  end 

  def pilote_nom
    pilote.nom
  end

end
