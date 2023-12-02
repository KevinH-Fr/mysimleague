module SaisonsHelper
    def liste_saisons(ligue)
        Saison.where(ligue_id: ligue)
    end
end
