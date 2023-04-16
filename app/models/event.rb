class Event < ApplicationRecord

  belongs_to :circuit, optional: true
  belongs_to :division, optional: true

  has_many :pilotes, dependent: :delete_all
  has_many :resultats, dependent: :delete_all

 # scope :division_courante, -> (division_courante) { where("division_id = ?", division_courante)}

  def feed_content
    id
  end 

  def nom_complet
    "n°#{numero} " " #{circuit.pays} " " #{circuit.nom}"
  end

  def nom_court
    "n°#{numero} " " #{circuit.nom}"
  end

  def icon_drapeau
    circuit.drapeau 
  end 

  def icon_carte
    circuit.carte 
  end 

end
