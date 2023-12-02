module PresencesHelper

    def verif_presence_existe(user, event)
        @event = Event.find(event)
        pilote = AssociationUser.where(user_id: user, division_id: @event.division).first.id

        presence = Presence.where(
          event_id: event, 
          association_user_id: pilote
        )
                                             
        presence.present?
    end

    def verif_propriete_presence(user, association_user)
      user.association_users.ids.include?(association_user)
    end

  
    def nb_presences_event(event)
      Presence.where(event_id: event, status: true).count
    end

    def nb_non_presences_event(event)
      Presence.where(event_id: event, status: false).count
    end

    def nb_non_reponses_event(event)
      pilotes_divisions = pilotes_division(Event.find(event).division_id).count
      reponses = Presence.where(event_id: event).count
      non_reponses = pilotes_divisions - reponses
    end


    def non_responding_users(event)
    
      # Get all active and valid association users in the division
      pilotes_division = pilotes_division(Event.find(event).division_id).ids

      responders = Presence.where(event_id: event).pluck(:association_user_id)
    
      non_responders = pilotes_division.difference(responders)
      non_responders 
    end
    


    def verif_delai_presence(event)
      event = Event.find(event)
      horaire = event.horaire
      current_time = Time.now

      if current_time < horaire
        true # presence can be set
      else
        false # over time limit
      end

    end

end
