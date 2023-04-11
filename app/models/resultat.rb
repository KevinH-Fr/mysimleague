class Resultat < ApplicationRecord
  belongs_to :event
  belongs_to :pilote
  belongs_to :equipe

  scope :event_courant, -> (event_courant) { where("event_id = ?", event_courant)}

  def feed_content
    id
  end 

  def pilote_nom
    pilote.nom
  end

end
