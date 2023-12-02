module SyntheseLicencesHelper

  def cumul_licence_user(event)
    user_licences = {}

    if event.present?
      
      association_users = pilotes_division(event.division)

      ligue = event.division.saison.ligue
      points_initial = ligue.points_initial

      association_users.each do |association_user|
        user_id = association_user.user.id
        user_licences[user_id] ||= { 
          user_id: user_id, 
          association_user_id: association_user.id, 
          perte_total: 0, 
          gain_total: 0, 
          solde: 0 }
      end

      licences = Licence.joins(event: { division: :saison })
                        .where("events.numero <= ?", event.numero)
                        .where("divisions.id = ?", event.division_id)
                        .joins(association_user: :user)
                        .where("association_users.actif = ?", true)
                        .where("association_users.valide = ?", true)

      licences.group_by { |licence| licence.association_user.user.id }.each do |user_id, user_licences_array|
        user_licences[user_id][:perte_total] = user_licences_array.sum { |licence| licence.perte.to_i }
        user_licences[user_id][:gain_total] = user_licences_array.sum { |licence| licence.gain.to_i }
      end

      user_licences.each do |_user_id, user_licence|
        user_licence[:solde] = points_initial.to_i  - user_licence[:perte_total].to_i + user_licence[:gain_total].to_i 
      end
    end

    user_licences.values
  end


  def calcul_recup_licence(event)

    maximum_solde =  event.division.saison.ligue.points_initial

    association_users = pilotes_division(event.division)
  
  # Calculate user_licences using cumul_licence_user method
  user_licences = cumul_licence_user(event).index_by { |data| data[:user_id] }
  
    pilotes_licences = association_users.map do |pilote|
      perte_trois_der_gp = 0
      recup_applicable = false 
      nb_points_recup = 0

      user_solde = user_licences[pilote.user.id][:solde] # Access user solde from user_licences


      previous_events = Event.where("numero <= ?", event.numero)
                             .where("division_id = ?", event.division_id)
                             .order(numero: :desc).limit(3)
  
      previous_events.each do |prev_event|
        perte_trois_der_gp += Licence.where(association_user: pilote)
                              .joins(event: { division: :saison })
                              .where(events: { numero: prev_event.numero }, divisions: { id: prev_event.division_id })
                              .sum(:perte)

        if perte_trois_der_gp == 0 && event.numero >= 4 && user_solde != maximum_solde
          recup_applicable = true
        else
          recup_applicable = false
        end
      end

      #  puts "_____________________________________________recup applicable #{recup_applicable}"

        #calculer le montant à recuperer pour ne pas depasser le max points
        if recup_applicable == true
          if maximum_solde - user_solde == 1 
            nb_points_recup = 1
          else
            nb_points_recup = 2
          end 
        end

      
      {
        id: pilote.id,
        user_id: pilote.user_id,
        nom: pilote.user.nom,
        perte_trois_der_gp: perte_trois_der_gp,
        recup_applicable: recup_applicable,
        user_solde: user_solde,
        nb_points_recup: nb_points_recup
      }
    end
    
    pilotes_licences
  end

  
  
  


end