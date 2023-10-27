module DivisionsHelper
  def pilotes_division_named(division)
    if division
      pilotes = division.association_users
                        .where(valide: true, actif: true)
                        .joins(:user) # Join with the user association
                        .order('users.nom ASC') # Order by the "nom" attribute in ascending order
                        .pluck('association_users.id', 'users.nom') # Pluck the required columns
    end
  end
  
  def pilotes_division_named_with_inactifs(division)
    if division
      pilotes = division.association_users
                        .where(valide: true)
                        .joins(:user) # Join with the user association
                        .order('users.nom ASC') # Order by the "nom" attribute in ascending order
                        .pluck('association_users.id', 'users.nom') # Pluck the required columns
    end
  end
    

  def liste_divisions(saison)
      Division.where(saison_id: saison)
  end

  def nb_pilotes_division(division)
      AssociationUser.where(division: division, actif: true, valide: true).count
  end

end
