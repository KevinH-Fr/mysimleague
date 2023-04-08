class Event < ApplicationRecord
  belongs_to :circuit
  belongs_to :saison
  belongs_to :division
  belongs_to :ligue
end
