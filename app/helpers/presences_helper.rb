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
