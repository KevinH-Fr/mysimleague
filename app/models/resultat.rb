class Resultat < ApplicationRecord
  belongs_to :event
  belongs_to :pilote
  belongs_to :equipe

  def feed_content
    id
  end 

end
