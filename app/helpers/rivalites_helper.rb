module RivalitesHelper

  def rivalite_indicators(pilote, leader, cumul)
    content = []
  
    if pilote == leader
      content << content_tag(:i, "", class: "fa fa-trophy fa-lg icon-indicator-resultat text-warning fw-bold pe-2")
    end
  
    content << content_tag(:span, cumul, class: "text-light fw-bold pe-2")
  
    content_span = content_tag(:span, content.join(" ").html_safe,
                               class: "text-light fw-bold position-absolute end-0 d-flex align-items-center",
                               style: "top: 50%; transform: translateY(-50%);")
    content_span
  end
  
  

  def equipe_banner_pilote_and_indicator(equipe, pilote, label, leader, cumul)
    if equipe.banniere.present?
      banner_and_pilote = equipe_banner_with_data(equipe, label)
      indicators = rivalite_indicators(pilote, leader, cumul)
      
      content_tag(:div, class: "equipe-banner-wrapper", style: "position: relative; ") do
        [banner_and_pilote, indicators].join.html_safe
      end
    end
  end

  def calcul_rivalite(pilote1, pilote2, division, event)
    @event = Event.find(event)
    events = Event.where('numero <= ? AND division_id = ?', @event.numero, division)

    cumulative_scores = { pilote1: 0, pilote2: 0 }
    scores_by_event = []

    events.each do |current_event|
      # Initialize points for each pilote for the current event
      pilote1_points = 0
      pilote2_points = 0
    
      pilote1_result = Resultat.find_by(association_user: pilote1.id, event: current_event)
      pilote2_result = Resultat.find_by(association_user: pilote2.id, event: current_event)
    
      # Check if both results are present
      if pilote1_result && pilote2_result
        pilote1_position_course = pilote1_result.course
        pilote2_position_course = pilote2_result.course
    
        pilote1_position_qualif = pilote1_result.qualification
        pilote2_position_qualif = pilote2_result.qualification
    
        if pilote1_result.dns && pilote2_result.dns
          # If both pilots are dns, no points
        elsif pilote1_result.dns
          # If pilote1 is dns, only one point for pilote2 if not dnf
          pilote2_points += 1 if pilote2_result.dnf == false
        elsif pilote2_result.dns
          # If pilote2 is dns, only one point for pilote1 if not dnf
          pilote1_points += 1 if pilote1_result.dnf == false
        elsif pilote1_result.dnf && pilote2_result.dnf
          # If both pilots are dnf, give only one point for the one in front in qualification
          if pilote1_position_qualif < pilote2_position_qualif
            pilote1_points += 1
          elsif pilote2_position_qualif < pilote1_position_qualif
            pilote2_points += 1
          end
        else
          # Update points based on positions for the current event
          pilote1_points += 1 if pilote1_position_course < pilote2_position_course
          pilote2_points += 1 if pilote2_position_course < pilote1_position_course
    
          pilote1_points += 1 if pilote1_position_qualif < pilote2_position_qualif
          pilote2_points += 1 if pilote2_position_qualif < pilote1_position_qualif
        end
      end
    
      # Accumulate points for each pilote across all events
      cumulative_scores[:pilote1] += pilote1_points
      cumulative_scores[:pilote2] += pilote2_points
    
      scores_by_event << { event: current_event.numero, pilote1: pilote1_points, pilote2: pilote2_points }
    end
    

    leading_pilote_id = cumulative_scores[:pilote1] > cumulative_scores[:pilote2] ? pilote1.id : cumulative_scores[:pilote1] < cumulative_scores[:pilote2] ? pilote2.id : nil

    { scores_by_event: scores_by_event, cumulative_scores: cumulative_scores, 
      pilote1_score: cumulative_scores[:pilote1], pilote2_score: cumulative_scores[:pilote2],
      leading_pilote_id: leading_pilote_id }
  end

  
end
