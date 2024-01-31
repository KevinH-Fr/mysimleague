module SyntheseLicencesEquipeHelper

  # adapter le code pour equipe au lieu de pilote
  def cumul_licence_equipe(event)
    equipe_licences = {}
  
    if event.present?
      equipes = equipes_division(event.division)
      ligue = event.division.saison.ligue
      points_initial = event.division.points_initial
  
      equipes.each do |equipe|
        equipe_licences[equipe.id] ||= { 
          equipe_id: equipe.id, 
          perte_total: 0, 
          gain_total: 0, 
          solde: 0 }
      end
  
      licences_equipe = LicencesEquipe.joins(event: { division: :saison })
                        .where("events.numero <= ?", event.numero)
                        .where("divisions.id = ?", event.division_id)
                        .where("licences_equipes.equipe_id IN (?)", equipes.pluck(:id))
  
      licences_equipe.each do |licence_equipe|
        equipe_id = licence_equipe.equipe_id
        equipe_licences[equipe_id] ||= { 
          equipe_id: equipe_id, 
          perte_total: 0, 
          gain_total: 0, 
          solde: 0 }
  
        equipe_licences[equipe_id][:perte_total] += licence_equipe.perte.to_i
        equipe_licences[equipe_id][:gain_total] += licence_equipe.gain.to_i
      end
  
      equipe_licences.each do |_equipe_id, equipe_licence|
        equipe_licence[:solde] = points_initial.to_i - equipe_licence[:perte_total].to_i + equipe_licence[:gain_total].to_i 
      end
    end
  
    equipe_licences.values
  end
  


  def calcul_recup_licence_equipe(event)
    maximum_solde = event.division.points_initial
  
    equipes = equipes_division(event.division)
  
    # Calculate equipe_licences using cumul_licence_equipe method
    equipe_licences = cumul_licence_equipe(event).index_by { |data| data[:equipe_id] }
  
    pilotes_licences_equipe = equipes.map do |equipe|
      perte_trois_der_gp = 0
      recup_trois_der_gp = 0
  
      recup_applicable = false
      nb_points_recup = 0
  
      equipe_solde = equipe_licences[equipe.id][:solde] # Access equipe solde from equipe_licences
  
      previous_events = Event.where("numero <= ?", event.numero)
                             .where("division_id = ?", event.division_id)
                             .order(numero: :desc).limit(3)
  
      previous_events.each do |prev_event|
        perte_trois_der_gp += LicencesEquipe.where(equipe_id: equipe.id)
                              .joins(event: { division: :saison })
                              .where(events: { numero: prev_event.numero }, divisions: { id: prev_event.division_id })
                              .sum(:perte)
  
        recup_trois_der_gp += LicencesEquipe.where(equipe_id: equipe.id)
                              .joins(event: { division: :saison })
                              .where(events: { numero: prev_event.numero }, divisions: { id: prev_event.division_id })
                              .sum(:gain)
  
        if perte_trois_der_gp == 0 && recup_trois_der_gp == 0 && event.numero >= 4 && equipe_solde != maximum_solde
          recup_applicable = true
        else
          recup_applicable = false
        end
      end
  
      # Calculating the amount to recover to not exceed the max points
      if recup_applicable == true
        nb_points_recup = [maximum_solde - equipe_solde, 2].min
      end
  
      {
        id: equipe.id,
        nom: equipe.nom,
        perte_trois_der_gp: perte_trois_der_gp,
        recup_applicable: recup_applicable,
        equipe_solde: equipe_solde,
        nb_points_recup: nb_points_recup
      }
    end
  
    pilotes_licences_equipe
  end
    
end