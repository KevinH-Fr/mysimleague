module RattachementsHelper

    def verif_appartenance_ligue(user, ligue)
        association_user = AssociationUser.where(
          ligue_id: ligue, 
          user_id: user)
                                              
        association_user.present?
    end

end
