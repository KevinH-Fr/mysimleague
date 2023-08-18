class Event < ApplicationRecord
  belongs_to :circuit
  belongs_to :division

  has_many :resultats, dependent: :destroy

  has_many :paris, dependent: :destroy
  has_many :dotds, dependent: :destroy
  has_many :licences, dependent: :destroy
  has_many :dois, dependent: :destroy
  has_many :presences, dependent: :destroy
  
  validates :numero, presence: true
  validates :circuit_id, presence: true
  validates :division_id, presence: true
  validates :horaire, presence: true

  enum typepari: {
    victoire: 'victoire',
    pole: 'pole',
    podium: 'podium',
    top10: 'top10'
  }

  def short_name
    "n°" "#{numero}" " #{circuit.nom}"  
  end

  def event_full_name
    "#{division.saison.ligue.nom}" " #{division.saison.nom}" " #{division.nom}" " n°" "#{numero}" " #{circuit.nom}"  
  end

  def feed_content
    id
  end 

  def self.recent(limit = 5)
    order(created_at: :desc).limit(limit)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["circuit_id", "created_at", "division_id", "horaire", "id", "numero", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["circuit", "division", "dois", "dotds", "licences", "paris", "presences", "resultats"]
  end

end
