module UsersHelper

  def divisions_for_current_user
    current_user.association_users.includes(division: [:saison]).map(&:division).uniq
  end
  

    def user_resultats_stats(user, user_compare)
        if user
          stats = {}
          user_stats = {}
          user_compare_stats = {}
          
          # Calculate stats for the main user
          user_stats[:nb_courses] = Resultat.where(association_user_id: user.association_users).count
          user_stats[:nb_victoires] = Resultat.where(association_user_id: user.association_users, course: 1).count
          user_stats[:nb_podiums] = Resultat.where(association_user_id: user.association_users, course: (1..3)).count
          user_stats[:nb_top5] = Resultat.where(association_user_id: user.association_users, course: (1..5)).count
          user_stats[:nb_top10] = Resultat.where(association_user_id: user.association_users, course: (1..10)).count
          user_stats[:nb_dnf] = Resultat.where(association_user_id: user.association_users, dnf: true).count
          user_stats[:nb_dns] = Resultat.where(association_user_id: user.association_users, dns: true).count
          user_stats[:moy_qualification] = Resultat.where(association_user_id: user.association_users)
            .where.not(qualification: nil, qualification: '')
            .average('CAST(qualification AS NUMERIC)').to_i

          user_stats[:moy_course] = Resultat.where(association_user_id: user.association_users)
              .average(:course).to_i

          user_stats[:delta_qaulif_course] =  user_stats[:moy_qualification] - user_stats[:moy_course] 

    # Calculate stats for the user_compare, if provided
          if user_compare
            user_compare_stats[:nb_courses] = Resultat.where(association_user_id: user_compare.association_users).count
            user_compare_stats[:nb_victoires] = Resultat.where(association_user_id: user_compare.association_users, course: 1).count
            user_compare_stats[:nb_podiums] = Resultat.where(association_user_id: user_compare.association_users, course: (1..3)).count
            user_compare_stats[:nb_top5] = Resultat.where(association_user_id: user_compare.association_users, course: (1..5)).count
            user_compare_stats[:nb_top10] = Resultat.where(association_user_id: user_compare.association_users, course: (1..10)).count
            user_compare_stats[:nb_dnf] = Resultat.where(association_user_id: user_compare.association_users, dnf: true).count
            user_compare_stats[:nb_dns] = Resultat.where(association_user_id: user_compare.association_users, dns: true).count
            user_compare_stats[:moy_qualification] = Resultat.where(association_user_id: user_compare.association_users)
              .where.not(qualification: nil, qualification: '')
              .average('CAST(qualification AS NUMERIC)').to_i

            user_compare_stats[:moy_course] = Resultat.where(association_user_id: user_compare.association_users)
              .average(:course).to_i

           user_compare_stats[:delta_qaulif_course] =  user_compare_stats[:moy_qualification] - user_compare_stats[:moy_course] 

          end
      
          # Calculate percentages for both users
          calculate_percentage = lambda do |stats_hash|
            if stats_hash[:nb_courses] > 0
              stats_hash[:tx_victoires] = sprintf("%.2f", (stats_hash[:nb_victoires].to_f / stats_hash[:nb_courses].to_f * 100))
              stats_hash[:tx_podiums] = sprintf("%.2f", (stats_hash[:nb_podiums].to_f / stats_hash[:nb_courses].to_f * 100))
              stats_hash[:tx_top5] = sprintf("%.2f", (stats_hash[:nb_top5].to_f / stats_hash[:nb_courses].to_f * 100))
              stats_hash[:tx_top10] = sprintf("%.2f", (stats_hash[:nb_top10].to_f / stats_hash[:nb_courses].to_f * 100))
              stats_hash[:tx_dnf] = sprintf("%.2f", (stats_hash[:nb_dnf].to_f / stats_hash[:nb_courses].to_f * 100))
              stats_hash[:tx_dns] = sprintf("%.2f", (stats_hash[:nb_dns].to_f / stats_hash[:nb_courses].to_f * 100))

            else
              stats_hash[:tx_victoires] = "0.00"
              stats_hash[:tx_podiums] = "0.00"
              stats_hash[:tx_top5] = "0.00"
              stats_hash[:tx_top10] = "0.00"
              stats_hash[:tx_dnf] = "0.00"
              stats_hash[:tx_dns] = "0.00"

            end
          end
      
          calculate_percentage.call(user_stats)
          calculate_percentage.call(user_compare_stats) if user_compare
      
          stats[:user_stats] = user_stats
          stats[:user_compare_stats] = user_compare_stats if user_compare
      
          return stats
        end
    end

    def user_resultats_scores(user, user_compare)
      resultats = {}
    
      if user
        user_resultats = Resultat.joins(:event)
                                 .where(association_user_id: user.association_users)
                                 .order("events.horaire ASC") # Order by horaire
                                 .pluck(:score, "events.horaire")
                                 .map { |score, horaire| { 
                                  score: score.nil? ? 0 : score.to_i, 
                                  event: horaire.strftime("%d %b %Y") } }
        
        resultats[:user] = user_resultats
      else
        resultats[:user] = []
      end
    
      if user_compare
        user_compare_resultats = Resultat.joins(:event)
                                         .where(association_user_id: user_compare.association_users)
                                         .order("events.horaire ASC") # Order by horaire
                                         .pluck(:score, "events.horaire")
                                         .map { |score, horaire| { 
                                          score: score.nil? ? 0 : score.to_i, 
                                          event: horaire.strftime("%d %b %Y") } }
        
        resultats[:user_compare] = user_compare_resultats
      else
        resultats[:user_compare] = []
      end
    
      resultats
    end


    def user_prochaine_course(user)
      if user
        association_users = user.association_users.where(actif: true, valide: true)
       
        division_ids = association_users.pluck(:division_id)
        related_events = Event.where(division_id: division_ids)
        
        # Find the event that is closest to Now
        closest_event = related_events.where('horaire >= ?', Time.now).order('horaire ASC').first
          
        if closest_event
          link_to menu_index_path(ligue: closest_event.division.saison.ligue.id, saison: closest_event.division.saison.id, division: closest_event.division.id, event: closest_event), 
                class: "btn btn-outline-primary m-0 p-2" do
            concat content_tag(:div, "Ma prochaine course", class: "fst-italic text-light mb-1")
            concat content_tag(:div, image_tag(closest_event.circuit.drapeau, class: "img-fluid rounded mx-2", width: "25", height: "15") + 
                  truncate(closest_event.short_name, length: 10), class: "fw-bold text-light")
          end
        end 

      end
    end    
    

    def user_badge_with_infos(user, category, value)

      link_to user_path(user), class: "no-underline" do
  
        content_tag(:div, class: "record-with-effect d-flex align-items-center p-2") do
          concat image_tag(user.webp_variant, class: "mini-profile-pic me-2", alt: "user picture")
          concat content_tag(:span, user.short_name, class: "fw-bold") 
          concat content_tag(:span, category, class: "mx-2 text-warning")
          concat content_tag(:span, number_to_human(value, units: { thousand: 'K', million: 'M', billion: 'B' }), class: "text-warning ms-2 me-1 fw-bold") 
        end
  
      end

    end
    
    def user_badge_with_infos_document(user, category, value)

      content_tag(:div, class: "record-with-effect d-flex align-items-center p-2") do
        
        concat cl_image_tag(user.profile_pic.url, class: "mini-profile-pic me-2", alt: "user picture")
        concat content_tag(:span, user.short_name, class: "fw-bold") 
        concat content_tag(:span, category, class: "mx-2 text-warning")
        concat content_tag(:span, number_to_human(value, units: { thousand: 'K', million: 'M', billion: 'B' }), class: "text-warning ms-2 me-1 fw-bold") 
      end

    end

end
  