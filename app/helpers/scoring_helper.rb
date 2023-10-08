module ScoringHelper
    def scoring_user
      users = User.includes(:paris, :dotds, :events).all
      user_scoring_data = []
      paris_ponderation = 10
      dotds_ponderation = 60
      profile_edit_points = 0
  
      users.each do |user|
        score_paris = user.paris.size * paris_ponderation
        score_dotds = user.dotds.size * dotds_ponderation

        profile_edit_points += 350 if user.profile_pic.present?
        profile_edit_points += 170 if user.twitch.present?
        profile_edit_points += 125 if user.slogan.present?
        profile_edit_points += 125 if user.bio.present?
        profile_edit_points += 75 if user.controlleur_type.present?
        profile_edit_points += 70 if user.pilote_prefere.present?

        score_events = user.events.size

        scoring = score_paris + score_dotds + score_events + profile_edit_points
  
        user_scoring_data << {
          user: user,
          score_paris: score_paris,
          score_dotds: score_dotds,
          score_events: score_events,
          score_edit_profile: profile_edit_points,
          scoring: scoring
        }
      end
  
      user_scoring_data.sort_by! { |data| -data[:scoring] }
  
      user_scoring_data.each_with_index do |data, index|
        data[:rank] = index + 1
      end
  
      user_scoring_data
    end

    def top_5_user_scores
        scoring_user[0..4]
    end
  
    def scoring_pilote
      users = User.all
      user_scoring_data = []
      victoire_ponderation = 12
      podium_ponderation = 8
      top5_ponderation = 4
      top10_ponderation = 2
      nb_courses_ponderation = 54
      dnf_ponderation = -240
      dns_ponderation = -180
      doi_ponderation = -340
  
      users.each do |user|
        user_stats = user_resultats_stats(user, false)
        nb_courses = user.association_users.joins(:resultats).count
        dnf_count = user.association_users.joins(:resultats).where(resultats: { dnf: true }).count
        dns_count = user.association_users.joins(:resultats).where(resultats: { dns: true }).count
        association_user_ids = user.association_users.pluck(:id)
        dois_resp_count = Doi.where(implique_id: association_user_ids, decision: 'responsable').count
  
        score_victoire = user_stats[:user_stats][:tx_victoires].to_i * victoire_ponderation 
        score_podium = user_stats[:user_stats][:tx_podiums].to_i * podium_ponderation 
        score_top10 = user_stats[:user_stats][:tx_top10].to_i * top10_ponderation 
        score_nb_courses = nb_courses * nb_courses_ponderation
        score_dnf = dnf_count * dnf_ponderation
        score_dns = dns_count * dns_ponderation
        score_doi = dois_resp_count * doi_ponderation
  
        scoring = score_victoire + score_podium + score_top10 + score_nb_courses + score_dnf + score_dns + score_doi
  
        user_scoring_data << {
          user: user,
          user_nom: user.nom,
          score_victoire: score_victoire,
          score_podium: score_podium,
          score_top10: score_top10,
          score_nb_courses: score_nb_courses,
          score_dnf: score_dnf,
          score_dns: score_dns,
          score_doi: score_doi,
          scoring: scoring
        }
      end
  
      user_scoring_data.sort_by! { |data| -data[:scoring] }
  
      user_scoring_data.each_with_index do |data, index|
        data[:rank] = index + 1
      end
  
      user_scoring_data
    end

    def top_5_pilote_scores
        scoring_pilote[0..4]
    end

  end
  