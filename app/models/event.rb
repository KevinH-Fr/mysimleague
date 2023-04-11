class Event < ApplicationRecord

  belongs_to :circuit
  belongs_to :division

  has_many :pilotes
  has_many :resultats

  scope :division_courante, -> (division_courante) { where("division_id = ?", division_courante)}

  def feed_content
    id
  end 

  def nom_complet
    "n°#{numero} " " #{circuit.pays} " " #{circuit.nom}"
  end

  def icon_drapeau
    circuit.drapeau 
  end 

  def icon_carte
    circuit.carte 
  end 

end
