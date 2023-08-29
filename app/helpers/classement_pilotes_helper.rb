module ClassementPilotesHelper
  
  def somme_user(event)
    user_scores = {}
  
    if event.present?
      association_users = pilotes_division(event.division)
      # puts "------------------------ #{association_users.ids}"
  
      association_users.each do |association_user|
        user_scores[association_user.user.id] ||= { association_user_id: association_user.id, user_id: association_user.user.id, score: 0, course_positions: Hash.new(0) }
      end
  
      resultats = Resultat.joins(event: { division: :saison })
                          .where("events.numero <= ?", event.numero)
                          .where("divisions.id = ?", event.division_id)
                          .joins(association_user: :user)
  
      resultats.group_by { |resultat| resultat.association_user.user.id }.each do |id, user_resultats|
        user_scores[id][:score] = user_resultats.sum(&:score)
        user_resultats.each do |resultat|
          course_position = resultat.course.to_i
          user_scores[id][:course_positions][course_position] += 1 if course_position.between?(1, 20)
        end
      end
  
    end
  
    ranked_users = user_scores.values.sort do |a, b|
      if a[:score] == b[:score]
        comparison_result = 0
        (1..20).each do |course_position|
          if a[:course_positions][course_position] != b[:course_positions][course_position]
            comparison_result = b[:course_positions][course_position] <=> a[:course_positions][course_position] # Higher count of course positions goes first
            puts "________________ #{comparison_result}"
            break
          end
        end
        comparison_result
      else
        b[:score] <=> a[:score] # Higher total score goes first
      end
    end.map.with_index(1) { |user, rank| { user_id: user[:user_id], association_user_id: user[:association_user_id], score: user[:score], rank: rank } }
  
    ranked_users
  end

  def compare_ranks(previous_event, current_event)

    if previous_event && current_event 
      previous_ranks = somme_user(previous_event).index_by { |user| user[:user_id] }
      current_ranks = somme_user(current_event).index_by { |user| user[:user_id] }
    
      comparison = {}
      previous_ranks.each do |user_id, previous_rank|
        current_rank = current_ranks[user_id]
        next unless current_rank
    
        comparison[user_id] = {
          previous_rank: previous_rank[:rank],
          current_rank: current_rank[:rank],
          delta_rank: previous_rank[:rank].to_i - current_rank[:rank].to_i
        }
      end
    
      comparison
    end 
  end
  

end