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

    def nb_pilotes_division(division)
       AssociationUser.where(division: division, actif: true, valide: true).count
    end

end
