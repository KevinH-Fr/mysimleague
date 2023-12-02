module ReglementsHelper
    #trouver articles defaut ou custom par ligue 
    
    def articles_reglement_ligue(ligue) 
        if Ligue.find(ligue).reglement_defaut
            Reglement.where(defaut: true).pluck(:id, :titre_article)
        else
            Reglement.where(ligue_id: ligue).pluck(:id, :titre_article)
        end 
    end
    
end
