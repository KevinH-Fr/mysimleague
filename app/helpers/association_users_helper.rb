module AssociationUsersHelper

  def pilotes_division(division)
      association_users = AssociationUser.where(
        division_id: division, 
        actif: true, 
        valide: true)
                                            
      association_users
      
  end

  def verif_appartenance_division(user, division)
    association_user = AssociationUser.where(
      division_id: division, 
      user_id: user,
      actif: true, 
      valide: true)
                                          
    association_user.present?
  end

  def association_user_from_user(user, division)
    association_user = AssociationUser.where(
      division_id: division, 
      user_id: user,
      actif: true, 
      valide: true)
                                          
    association_user.first
  end


      
end

