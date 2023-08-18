module DivisionsHelper

    def pilotes_division_named(division)
        if division
            #     pilotes = division.association_users.includes(:user).map { |au| [au.id, au.user.nom] }
            pilotes = division.association_users.map { |au| [au.id, au.user.nom] }
        
        end 
    end

    def liste_divisions(saison)
        Division.where(saison_id: saison)
    end

end
