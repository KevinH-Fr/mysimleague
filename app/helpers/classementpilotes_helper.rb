module ClassementpilotesHelper

  def pilotesDivisionCourante 
    pilotesFiltreDivisionCourante
  end

  def numeroCourant
    Event.find(params[:eventId]).numero
  end

  def resultatsFiltreDivisionCourante()
   
    if divisionCourante.present?    
      Resultat.joins(event: :division).where(event: { division_id: divisionCourante, numero: numeroCourant })
    end
  end

    # classement avec index et tri
    
    def ordered_points_by_pilote
      resultats = resultatsFiltreDivisionCourante
        
      scores = {}
      pilotesFiltreDivisionCourante.each do |pilote|
        score = resultats.where(pilote: pilote).sum(:score)
        scores[pilote] = score
      end
    
      # Sort the scores hash by descending score
      sorted_scores = scores.sort_by { |_, v| -v }.to_h
    
      # Assign index based on the sorted order
      sorted_scores.each_with_index do |(pilote, score), index|
        sorted_scores[pilote] = { nom: pilote.nom, score: score, index: index + 1 }
      end
    
      sorted_scores
    end
    
    
end
