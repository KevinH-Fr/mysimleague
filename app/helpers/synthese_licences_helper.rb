module SyntheseLicencesHelper

  def cumul_licence_user(event)
    user_licences = {}

    if event.present?
      association_users = pilotes_division(event.division)

      ligue = event.division.saison.ligue
      points_initial = ligue.points_initial

      association_users.each do |association_user|
        user_id = association_user.user.id
        user_licences[user_id] ||= { user_id: user_id, association_user_id: association_user.id, perte_total: 0, gain_total: 0, solde: 0 }
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

end
