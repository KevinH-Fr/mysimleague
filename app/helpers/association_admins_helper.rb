module AssociationAdminsHelper

    def verif_admin_ligue(user, ligue)
        association_users_admins = AssociationAdmin.where(
            ligue_id: ligue, 
            user_id: user,
            actif: true, 
            valide: true)
            .group(:user_id)
                                                
        association_users_admins.present?
    end
    
    def liste_admins_ligue(ligue)
        association_users_admins = AssociationAdmin.joins(:user).where(
          ligue_id: ligue,
          actif: true, 
          valide: true
        ).select("association_admins.id as id, users.nom as user_nom")
        
        association_users_admins
      end
      


end
