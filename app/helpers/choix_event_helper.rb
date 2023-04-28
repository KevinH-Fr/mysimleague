# helper pour mise en commun des methodes de choxi event
module ChoixEventHelper

    def ligueCourante()
        params[:ligueId]
    end

    def saisonCourante()
        params[:saisonId]
    end

    def divisionCourante()
        params[:divisionId]
    end

    def eventCourant()
        params[:eventId]
    end

    def ligues()
        Ligue.all
    end

    def filtreLigueCouranteSaisons()
        # filtre saisons ligue courante
        if ligueCourante.present?
            ligue = Ligue.find(ligueCourante) 
            ligue.saisons
        end
    end

    def filtreSaisonCouranteDivisions()
        # filtre divisions saison courante
        if saisonCourante.present?
            saison = Saison.find(saisonCourante) 
            saison.divisions
        end
    end

    def filtreDivisionCouranteEvents()
        # filtre events division courante
        if divisionCourante.present?
            division = Division.find(divisionCourante) 
            division.events
        end
    end

    def filtreEventCouranteResultats()
        # filtre resultats event courant
        if eventCourant.present?
            event = Event.find(eventCourant) 
            event.resultats
        end
    end

end
