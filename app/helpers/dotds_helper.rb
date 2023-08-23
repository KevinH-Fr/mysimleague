module DotdsHelper
    def nb_votes_dotd_event(event)
      Dotd.where(event_id: event).count
    end
  
    def max_dotd_event_pilote(event)
      counts_by_pilote = Dotd.where(event_id: event).group(:association_user_id).count
      max_count = counts_by_pilote.values.max
      max_pilote_ids = counts_by_pilote.select { |_, v| v == max_count }.keys
      max_pilote_ids
    end
  
    def resultat_dotd_courant(event)
        max_pilote_ids = max_dotd_event_pilote(event)
        counts_by_pilote = Dotd.where(event_id: event).group(:association_user_id).count
        max_count = counts_by_pilote.values.max
      
        if max_pilote_ids.empty?
          "Aucun vote pour l'instant." # Return a message indicating no votes yet
        elsif max_pilote_ids.count > 1
          "Il y a une égalité entre les pilotes suivants:<br>".html_safe +
            max_pilote_ids.map { |pilote_id|
              "#{AssociationUser.find(pilote_id).user.nom} (#{max_count} votes)"
            }.join("<br>").html_safe
        else
           "#{AssociationUser.find(max_pilote_ids.first).user.nom} (#{max_count} #{'vote'.pluralize(max_count)})"
        end

      end


    def verif_presence_dotd(user, event)
      Dotd.where(user_id: user, event_id: event).present?
    end

    def verif_delai_dotd(event)
      event = Event.find(event)
      horaire = event.horaire
      time_difference = Time.now - horaire
      hours_difference = time_difference / 3600
      allowed_hours = 36
    
      if hours_difference <= allowed_hours
        true
      else
        false
      end
    end


    def verif_user_dotd(user, votant)
      if user.id == votant 
        true
      end
    end

end
  