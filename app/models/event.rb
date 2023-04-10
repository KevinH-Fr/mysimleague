class Event < ApplicationRecord
  belongs_to :circuit
 # belongs_to :saison
  belongs_to :division
 # belongs_to :ligue

  scope :division_courante, -> (division_courante) { where("division_id = ?", division_courante)}


  def feed_content
    id
  end 

end
