class BaseSetup < ApplicationRecord
    belongs_to :game
    belongs_to :categorie_parametre
    has_many :comportement_base_setups  
end
