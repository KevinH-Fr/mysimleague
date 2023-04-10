class Event < ApplicationRecord

  # belongs_to :ligue
  # belongs_to :saison

  belongs_to :circuit
  belongs_to :division

  has_many :resultats



  scope :division_courante, -> (division_courante) { where("division_id = ?", division_courante)}


  def feed_content
    id
  end 

end
