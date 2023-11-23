module ScoringHelper
    

  def scoring_edit_profile(user)
    profile_edit_points = 0
    profile_edit_points += 350 if user.profile_pic.present?
    profile_edit_points += 170 if user.twitch.present?
    profile_edit_points += 125 if user.slogan.present?
    profile_edit_points += 125 if user.bio.present?
    profile_edit_points += 75 if user.controlleur_type.present?
    profile_edit_points += 70 if user.pilote_prefere.present?
    profile_edit_points
  end

  def scoring_paris(user)
    paris_ponderation = 10
    score_paris = user.paris_score.to_i * paris_ponderation
  end

  def scoring_dotds(user)
    dotds_ponderation = 60
    score_dotds = user.dotds_score.to_i * dotds_ponderation
  end

  def scoring_user_sum(user)
    user.action_count.to_i + scoring_edit_profile(user) + scoring_paris(user) +  scoring_dotds(user)
  end
    
  def ranked_users
    users = User.includes(profile_pic_attachment: :blob).all
    sorted_users = users.sort_by { |user| -scoring_user_sum(user) }
    ranked_users = sorted_users.map do |user|
      {
        user: user,
        rank: sorted_users.index(user) + 1,
        scoring: scoring_user_sum(user),
        score_paris: scoring_paris(user),
        score_dotds: scoring_dotds(user),
        score_edit_profile: scoring_edit_profile(user)
      }
    end
  end


  def top_5_user_scores
    ranked_users[0..4]
  end


  def top_1_user_scores
    ranked_users.first
  end






  # nouveau scoring pilote 
  # incrementer le nouveau score a chaque creation ou edition de resultat 
  # pose probleme en cas d'édition d'un resultat car mauvause valeur incrementée 

  # ajouter le field dans la db 
  def scoring_pilote_victoire(user)
    calculate_score(user, :tx_victoires, 12)
  end
  
  def scoring_pilote_podium(user)
    calculate_score(user, :tx_podiums, 8)
  end
  
  def scoring_pilote_top10(user)
    calculate_score(user, :tx_top10, 2)
  end

    
  def scoring_pilote_nb_course(user)
    calculate_score(user, :nb_courses, 118)
  end

  def scoring_pilote_nb_course_malus(user)
    scoring_pilote_nb_course(user) == 1 ? -950 : 0
  end 


      
  def scoring_pilote_dnf(user)
    user.association_users.joins(:resultats).where(resultats: { dnf: true }).count *  -100
  end

  def scoring_pilote_dns(user)
    user.association_users.joins(:resultats).where(resultats: { dns: true }).count *  -80
  end

  def scoring_pilote_doi(user)
    association_user_ids = user.association_users.pluck(:id)
    Doi.where(implique_id: association_user_ids, decision: 'responsable').count * -140
  end



  def scoring_pilote_sum_points(user)
    user.association_users.joins(:resultats).sum(:score) * 3
  end 

  
  def scoring_pilote_sum(user)
    scoring_pilote_victoire(user) + scoring_pilote_podium(user) + scoring_pilote_top10(user) +
    scoring_pilote_nb_course(user) + scoring_pilote_nb_course_malus(user) +
    scoring_pilote_dnf(user) + scoring_pilote_dns(user) + scoring_pilote_doi(user) + scoring_pilote_sum_points(user)
  end
  

  def ranked_pilotes
    pilotes = User.includes(:profile_pic_attachment).all
    sorted_pilotes = pilotes.sort_by { |pilote| -scoring_pilote_sum(pilote) }
  
    ranked_pilotes = sorted_pilotes.map do |pilote|
      {
        pilote: pilote,
        rank: sorted_pilotes.index(pilote) + 1,
        score_victoire: scoring_pilote_victoire(pilote) ,
        score_podium: scoring_pilote_podium(pilote) ,
        score_top10: scoring_pilote_top10(pilote) ,
        score_nb_courses: scoring_pilote_nb_course(pilote) ,
        score_malus_nb_courses: scoring_pilote_nb_course_malus(pilote) ,
        score_sum_points: scoring_pilote_sum_points(pilote),
        score_dnf: scoring_pilote_dnf(pilote) ,
        score_dns: scoring_pilote_dns(pilote) ,
        score_doi: scoring_pilote_doi(pilote) ,
        scoring: scoring_pilote_sum(pilote),
        # Add other scoring attributes as needed
      }
    end
  end
  

  def ranked_pilotes_top_from_db
    top_pilotes = User.order(score_pilote: :desc).limit(5)
    ranked_pilotes = []
  
    top_pilotes.each_with_index do |user, index|
      ranked_pilotes << { 
        user: user, 
        rank: index + 1,
        score: user.score_pilote
      }
    end
  
    ranked_pilotes
  end
  






    # anien scoring_pilote


  
    def scoring_pilote
      users = User.all
      user_scoring_data = []
      victoire_ponderation = 12 
      podium_ponderation = 8
      top5_ponderation = 4
      top10_ponderation = 2
      nb_courses_ponderation = 118
      dnf_ponderation = -100
      dns_ponderation = -80
      doi_ponderation = -140
  
      users.each do |user|
        user_stats = user_resultats_stats(user, false)
        nb_courses = user.association_users.joins(:resultats).count
        sum_points = user.association_users.joins(:resultats).sum(:score)

        dnf_count = user.association_users.joins(:resultats).where(resultats: { dnf: true }).count
        dns_count = user.association_users.joins(:resultats).where(resultats: { dns: true }).count
        association_user_ids = user.association_users.pluck(:id)
        dois_resp_count = Doi.where(implique_id: association_user_ids, decision: 'responsable').count
  
        score_victoire = user_stats[:user_stats][:tx_victoires].to_i * victoire_ponderation 
        score_podium = user_stats[:user_stats][:tx_podiums].to_i * podium_ponderation 
        score_top10 = user_stats[:user_stats][:tx_top10].to_i * top10_ponderation 
        score_nb_courses = (nb_courses * nb_courses_ponderation)
        score_malus_nb_courses = nb_courses == 1 ? -950 : 0
        score_sum_points = sum_points * 3
        score_dnf = dnf_count * dnf_ponderation
        score_dns = dns_count * dns_ponderation
        score_doi = dois_resp_count * doi_ponderation
  
        scoring = score_victoire + score_podium + score_top10 + score_nb_courses + score_sum_points + score_dnf + score_dns + score_doi #score_malus_nb_courses
  
        user_scoring_data << {
          user: user,
          user_nom: user.nom,
          score_victoire: score_victoire,
          score_podium: score_podium,
          score_top10: score_top10,
          score_nb_courses: score_nb_courses,
          score_malus_nb_courses: score_malus_nb_courses,
          score_sum_points: score_sum_points * 3,
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

    private
  
    def calculate_score(user, stat_key, ponderation)
      user_stats = user_resultats_stats(user, false)
      user_stats[:user_stats][stat_key].to_i * ponderation
    end
  
    
  end