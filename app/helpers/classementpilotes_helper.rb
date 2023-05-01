module ClassementpilotesHelper

  def pilotesDivisionCourante 
    pilotesFiltreDivisionCourante
  end

  def numeroCourant
    Event.find(params[:eventId]).numero
  end

  def resultatsFiltreDivisionCourante()
   
    if divisionCourante.present?    
      Resultat.joins(event: :division).where(event: { division_id: divisionCourante, numero: (0..numeroCourant) })
    end
  end

  def resultatsFiltreDivisionCourante_n_1()
   
    if divisionCourante.present?    
      Resultat.joins(event: :division).where(event: { division_id: divisionCourante, numero: (0..numeroCourant - 1) })
    end
  end

  def maximumPoints()
    max_pilote_sum = resultatsFiltreDivisionCourante.group(:pilote).sum(:score).values.max.to_i
    pilote_with_max_sum = resultatsFiltreDivisionCourante.group(:pilote).sum(:score).key(max_pilote_sum)
    sum_score_of_pilote_with_max_sum = resultatsFiltreDivisionCourante.where(pilote: pilote_with_max_sum).sum(:score).to_i
  end

    # classement avec index et tri
    
  def ordered_points_by_pilote
    resultats = resultatsFiltreDivisionCourante
        
    scores = {}
    pilotesFiltreDivisionCourante.each do |pilote|
      score = resultats.where(pilote: pilote).sum(:score)
      delta_score = score - maximumPoints
      scores[pilote] = { score: score, delta_score: delta_score }
    end
  
    # Sort the scores hash by descending score, and then by ascending delta_score
    sorted_scores = scores.sort_by { |_, v| [-v[:score], v[:delta_score]] }.to_h
  
    # Assign index based on the sorted order
    sorted_scores.each_with_index do |(pilote, score), index|
      sorted_scores[pilote] = { nom: pilote.nom, score: score[:score], delta_score: score[:delta_score], index: index + 1 }
    end
  
    sorted_scores
  end

  # classement avec index et tri n-1

  def ordered_points_by_pilote_n_1
    resultats = resultatsFiltreDivisionCourante_n_1
        
    scores = {}
    pilotesFiltreDivisionCourante.each do |pilote|
      score = resultats.where(pilote: pilote).sum(:score)
      delta_score = score - maximumPoints
      scores[pilote] = { score: score, delta_score: delta_score }
    end
  
    # Sort the scores hash by descending score, and then by ascending delta_score
    sorted_scores = scores.sort_by { |_, v| [-v[:score], v[:delta_score]] }.to_h
  
    # Assign index based on the sorted order
    sorted_scores.each_with_index do |(pilote, score), index|
      sorted_scores[pilote] = { nom: pilote.nom, score: score[:score], delta_score: score[:delta_score], index: index + 1 }
    end
  
    sorted_scores
  end

    # trouver position pilote x dans classement n
    def rank_by_pilote_id(pilote_id)
      if numeroCourant == 1
        0
      else
        sorted_scores = ordered_points_by_pilote
        pilote_scores = sorted_scores.select { |pilote, _| pilote.id == pilote_id }.values.first
        pilote_scores[:index]
      end
    end

  # trouver position pilote x dans classement n-1
  def rank_by_pilote_id_n_1(pilote_id)
    if numeroCourant == 1
      0
    else
      sorted_scores = ordered_points_by_pilote_n_1
      pilote_scores = sorted_scores.select { |pilote, _| pilote.id == pilote_id }.values.first
      pilote_scores[:index]
    end
  end

  def delta_rank_pilote_id(pilote_id)
     rank_by_pilote_id(pilote_id) - rank_by_pilote_id_n_1(pilote_id)
  end

  
    
end
