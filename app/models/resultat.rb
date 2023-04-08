class Resultat < ApplicationRecord
  belongs_to :event
  belongs_to :pilote
  belongs_to :equipe
end
