class BaseSetup < ApplicationRecord
    belongs_to :game
    belongs_to :categorie_parametre
    has_many :comportement_base_setups  

    def formatted_val_min
        if number_format == 'entiers'
          val_min.to_i
        else
          val_min
        end
    end

    def formatted_val_max
        if number_format == 'entiers'
          val_max.to_i
        else
            val_max
        end
    end

end
