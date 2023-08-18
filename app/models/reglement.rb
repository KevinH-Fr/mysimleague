class Reglement < ApplicationRecord
  belongs_to :ligue, optional: true
end
