module RivalitesHelper

  def rivalite_lead_indicator(rivalite)
    content = []

    if rivalite
      content << content_tag(:span, "leader", class: "badge p-1 text-center rounded bg-light text-danger fw-bold me-1")
    end

    content_span = content_tag(:span, content.join(" ").html_safe, 
      class: "text-light fw-bold position-absolute end-0",
      style: "top: 6px;") 
    content_span
  end

  

  def equipe_banner_pilote_and_indicator(equipe, pilote, rivalite)
    if equipe.banniere.present?
      banner_and_pilote = equipe_banner_with_data(equipe, pilote)
      indicator = rivalite_lead_indicator(rivalite)

      content_tag(:div, class: "equipe-banner-wrapper", style: "position: relative; ") do
        [banner_and_pilote, indicator].join.html_safe
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

        # Check if either pilot has "dns" for both qualification and course
        if (pilote1_result.qualification != "dns" || pilote1_result.course != "dns") &&
           (pilote2_result.qualification != "dns" || pilote2_result.course != "dns")

          # Update points based on positions for the current event
          pilote1_points += 1 if pilote1_position_course < pilote2_position_course && pilote1_result.course != "dns"
          pilote2_points += 1 if pilote2_position_course < pilote1_position_course && pilote2_result.course != "dns"

          pilote1_points += 1 if pilote1_position_qualif < pilote2_position_qualif && pilote1_result.qualification != "dns"
          pilote2_points += 1 if pilote2_position_qualif < pilote1_position_qualif && pilote2_result.qualification != "dns"
        end
      end

      scores_by_event << { event: current_event.numero, pilote1: pilote1_points, pilote2: pilote2_points }

      # Accumulate points for each pilote across all events
      cumulative_scores[:pilote1] += pilote1_points
      cumulative_scores[:pilote2] += pilote2_points
    end

    { scores_by_event: scores_by_event, cumulative_scores: cumulative_scores, 
      pilote1_score: cumulative_scores[:pilote1],   pilote2_score: cumulative_scores[:pilote2]  }
  end
end
