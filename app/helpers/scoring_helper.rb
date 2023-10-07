module ScoringHelper

    def scoring_user
        users = User.all
        user_scoring_data = []

        paris_ponderation = 5
        dotds_ponderation = 50

        # Calculate scoring for each user and store it in the array
        users.each do |user|
            scoring = 
                (user.paris.count * paris_ponderation) + 
                (user.dotds.count * dotds_ponderation) + 
                user.events.count
            user_scoring_data << { user: user, scoring: scoring }
        end

        # Sort the user scoring data by scoring in descending order
        user_scoring_data.sort_by! { |data| -data[:scoring] }

        # Assign ranks to users based on their position in the sorted array
        user_scoring_data.each_with_index do |data, index|
            data[:rank] = index + 1
        end
        
        user_scoring_data # Return the array of user scoring data
    end

    def scoring_pilote
        users = User.all
        user_scoring_data = []

        victoire_ponderation = 10
        podium_ponderation = 6
        top5_ponderation = 3
        top10_ponderation = 1
        dnf_ponderation = -10
        dns_ponderation = -5
        doi_ponderation = -12

        users.each do |user|
            user_stats = user_resultats_stats(user, false)
            dnf_count = user.association_users.joins(:resultats).where(resultats: { dnf: true }).count
            dns_count = user.association_users.joins(:resultats).where(resultats: { dns: true }).count
    
            # Get the IDs of associated association_users
            association_user_ids = user.association_users.pluck(:id)
            
            # Count the number of dois with implique_id matching the association_user IDs
            dois_resp_count = Doi.where(implique_id: association_user_ids, decision: 'responsable').count

            score_victoire = user_stats[:user_stats][:tx_victoires].to_i * victoire_ponderation 
            score_podium = user_stats[:user_stats][:tx_podiums].to_i * podium_ponderation 
            score_top10 = user_stats[:user_stats][:tx_top10].to_i * top10_ponderation
            score_dnf = dnf_count * dnf_ponderation
            score_dns = dns_count * dns_ponderation
            score_doi = dois_resp_count * doi_ponderation
            
            scoring = (
              score_victoire + score_podium + score_top10 + 
              score_dnf + score_dns + score_doi
            )

            user_scoring_data << {
                user: user,
                user_nom: user.nom,
                score_victoire: score_victoire, 
                score_podium: score_podium,
                score_top10: score_top10,
                score_dnf: score_dnf,
                score_dns: score_dns,
                score_doi: score_doi,
                scoring: scoring
            }
        end

        # Sort the user scoring data by scoring in descending order
        user_scoring_data.sort_by! { |data| -data[:scoring] }

        # Assign ranks to users based on their position in the sorted array
        user_scoring_data.each_with_index do |data, index|
            data[:rank] = index + 1
        end

        user_scoring_data # Return the array of user scoring data
    end
      

end
