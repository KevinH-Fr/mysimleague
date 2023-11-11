module RivalitesHelper
    def calcul_rivalite(pilote1, pilote2, division, event)
      # Initialize points for each pilote
      pilote1_points = 0
      pilote2_points = 0
  
      @event = Event.find(event)
      events = Event.where('numero <= ? AND division_id = ?', @event.numero, division)
  
      scores = []  # Array to store scores for each event
  
      events.each do |current_event|
  
          pilote1_position_course = Resultat.where(association_user: pilote1.id, event: current_event).first.course
          pilote2_position_course = Resultat.where(association_user: pilote2.id, event: current_event).first.course

          pilote1_position_qualif = Resultat.where(association_user: pilote1.id, event: current_event).first.qualification
          pilote2_position_qualif = Resultat.where(association_user: pilote2.id, event: current_event).first.qualification

          # Update points based on positions
          pilote1_points += 1 if pilote1_position_course < pilote2_position_course
          pilote2_points += 1 if pilote2_position_course < pilote1_position_course

          pilote1_points += 1 if pilote1_position_qualif < pilote2_position_qualif
          pilote2_points += 1 if pilote2_position_qualif < pilote1_position_qualif

  
        scores << { event: current_event.numero, pilote1: pilote1_points, pilote2: pilote2_points }
      end
  
      scores  # Return scores as an array of hashes
    end
  end
  