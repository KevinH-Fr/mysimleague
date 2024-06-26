module ClassementEquipesHelper
    # somme des resultats de la div courante jusquau numero courant inclus 

    def somme_equipe(event)
      equipe_scores = {}
    
      if event.present?
        resultats = Resultat.includes(association_user: :equipe)
                             .joins(event: { division: :saison })
                             .where("events.numero <= ?", event.numero)
                             .where("divisions.id = ?", event.division_id)
    
        resultats.each do |resultat|
          equipe = resultat.association_user.equipe
          next unless equipe.actif # Skip if equipe is not active
    
          equipe_scores[equipe.id] ||= { score_sum: 0, equipe_nom: equipe.nom }
          equipe_scores[equipe.id][:score_sum] += resultat.score
        end
      end
    
      ranked_equipes = equipe_scores.sort_by { |_equipe_id, data| -data[:score_sum] }
                                    .map.with_index(1) do |(equipe_id, data), rank|
                                      {
                                        equipe_id: equipe_id,
                                        nom: data[:equipe_nom],
                                        score_sum: data[:score_sum],
                                        rank: rank
                                      }
                                    end
    
      ranked_equipes
    end
    
    
  
      def compare_equipe_ranks(previous_event, current_event)
        previous_ranks = somme_equipe(previous_event).index_by { |equipe| equipe[:equipe_id] }
        current_ranks = somme_equipe(current_event).index_by { |equipe| equipe[:equipe_id] }
      
        comparison = {}
        previous_ranks.each do |equipe, previous_rank|
          current_rank = current_ranks[equipe]
          next unless current_rank
      
          comparison[equipe] = {
            previous_rank: previous_rank[:rank],
            current_rank: current_rank[:rank],
            delta_rank: previous_rank[:rank] - current_rank[:rank],
            previous_score: previous_rank[:score_sum]
          }
        end
      
        comparison

      end


    end
