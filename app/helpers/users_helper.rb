module UsersHelper
  
    def divisions_for_current_user
        current_user.association_users.includes(:division).map(&:division).uniq
    end

    def user_resultats_stats(user)
        stats = {}
        
        stats[:nb_courses] = Resultat.where(association_user_id: user.association_users).count

        stats[:nb_victoires] = Resultat.where(association_user_id: user.association_users, course: 1).count
        if stats[:nb_courses] > 0
           stats[:tx_victoires] = sprintf("%.2f", (stats[:nb_victoires].to_f / stats[:nb_courses].to_f * 100))
        else
          stats[:tx_victoires] = "0.00" # Handle the case when there are no courses
        end

        stats[:nb_podiums] = Resultat.where(association_user_id: user.association_users, course: (1..3)).count
        if stats[:nb_courses] > 0
            stats[:tx_podiums] = sprintf("%.2f", (stats[:nb_podiums].to_f / stats[:nb_courses].to_f * 100))
        else
           stats[:tx_podiums] = "0.00" # Handle the case when there are no courses
        end

        stats[:nb_top5] = Resultat.where(association_user_id: user.association_users, course: (1..5)).count
        if stats[:nb_top5] > 0
            stats[:tx_top5] = sprintf("%.2f", (stats[:nb_top5].to_f / stats[:nb_courses].to_f * 100))
        else
           stats[:tx_top5] = "0.00" # Handle the case when there are no courses
        end
        
        stats[:nb_top10] = Resultat.where(association_user_id: user.association_users, course: (1..10)).count
        if stats[:nb_top10] > 0
            stats[:tx_top10] = sprintf("%.2f", (stats[:nb_top10].to_f / stats[:nb_courses].to_f * 100))
        else
           stats[:tx_top5] = "0.00" # Handle the case when there are no courses
        end

        return stats
    end
end
  