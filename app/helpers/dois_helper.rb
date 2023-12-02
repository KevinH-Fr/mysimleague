module DoisHelper
    def verif_delai_doi(event)
        event = Event.find(event)
        horaire = event.horaire
        time_difference = Time.now - horaire
        hours_difference = time_difference / 3600
        allowed_hours = 24
      
        if hours_difference <= allowed_hours
          true
        else
          false
        end
    end
end
