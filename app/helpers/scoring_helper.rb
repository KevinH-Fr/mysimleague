module ScoringHelper
  
  #scoring user par categorie

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

  # sum des scores user 

  def scoring_user_sum(user)
    user.action_count.to_i + scoring_edit_profile(user) + scoring_paris(user) +  scoring_dotds(user)
  end

  # ranked users 
  def ranked_users_from_db
    users = User.all.includes(profile_pic_attachment: :blob)
    filtered_users = users.reject { |user| user[:admin] == true }

    sorted_users = filtered_users.sort_by { |user| -sum_user_fields(user) }
    rankings = sorted_users.map.with_index do |user, index|
      {
        user: user,
        rank: index + 1,
        scoring: sum_user_fields(user),
        score_paris: user.paris_score,
        score_dotds: user.dotds_score,
        score_edit_profile: user.edit_profile_score
      }
    end
    rankings
  end
  
  def top_5_user_scores
    ranked_users_from_db[0..4]
  end

  def top_1_user_scores
    ranked_users_from_db.first
  end

  def displayed_top_1_user
    user = top_1_user_scores[:user]

    link_to user_path(user), class: "no-underline" do

      content_tag(:div, class: "record-with-effect d-flex align-items-center p-2") do
        concat image_tag(user.webp_variant, class: "mini-profile-pic me-2", alt: "user picture")
        concat content_tag(:span, user.short_name, class: "fw-bold") 
        concat content_tag(:span, number_to_human(sum_user_fields(user), units: { thousand: 'K', million: 'M', billion: 'B' }), class: "text-warning ms-2 me-1") 
        concat content_tag(:span, "pts user", class: "text-warning")
        concat content_tag(:i, "", class: "fa fa-xl fa-star mx-1 text-warning")
      end

    end 
  end

  def icon_leader_user(user)
    top_user = top_1_user_scores[:user].id
    user == top_user ? content_tag(:i, "", class: "fa fa-xl fa-star me-1 text-warning") : ""
  end


  # scoring pilote 

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
  
  # charge les details via calculs helper que dans scoring details
  def ranked_pilote_details(user)
      {
        pilote: user,
        score_victoire: scoring_pilote_victoire(user),
        score_podium: scoring_pilote_podium(user),
        score_top10: scoring_pilote_top10(user),
        score_nb_courses: scoring_pilote_nb_course(user),
        score_malus_nb_courses: scoring_pilote_nb_course_malus(user),
        score_sum_points: scoring_pilote_sum_points(user),
        score_dnf: scoring_pilote_dnf(user),
        score_dns: scoring_pilote_dns(user),
        score_doi: scoring_pilote_doi(user),
        scoring: scoring_pilote_sum(user),
      }
  end 

  def ranked_pilotes_from_db
    top_pilotes = User.order(score_pilote: :desc)
    ranked_pilotes = []
  
    top_pilotes.each_with_index do |user, index|
      ranked_pilotes << { 
        user: user, 
        rank: index + 1,
        score: user.score_pilote.to_i
      }
    end
  
    ranked_pilotes
  end

  def top_5_pilotes_scores
    ranked_pilotes_from_db[0..4]
  end


  def top_1_pilote_scores
    ranked_pilotes_from_db.first
  end

  def displayed_top_1_pilote
    #reprendre
    pilote = top_1_pilote_scores[:user]

    link_to user_path(pilote), class: "no-underline" do
      content_tag(:div, class: "record-with-effect d-flex align-items-center p-2") do
        concat image_tag(pilote.webp_variant, class: "mini-profile-pic me-2", alt: "user picture")
        concat content_tag(:span, pilote.short_name, class: "fw-bold") 
        concat content_tag(:span, number_to_human(scoring_pilote_sum(pilote), units: { thousand: 'K', million: 'M', billion: 'B' }) , class: "text-warning ms-2 me-1") 
        concat content_tag(:span, "pts pilote", class: "text-warning")
        concat content_tag(:i, "", class: "fa fa-xl fa-medal mx-2 text-warning")
      end
    end 
  end

  def icon_leader_pilote(user)
    top_pilote = top_1_pilote_scores[:user].id
    user == top_pilote ? content_tag(:i, "", class: "fa fa-xl fa-medal mx-1 text-warning") : ""
  end
  

  private
  
    def calculate_score(user, stat_key, ponderation)
      user_stats = user_resultats_stats(user, false)
      user_stats[:user_stats][stat_key].to_i * ponderation
    end

    def sum_user_fields(user)

      dotds_ponderation = 60
      paris_ponderation = 10

      user.edit_profile_score.to_i + 
      user.action_count.to_i + 
      ( user.paris_score.to_i * paris_ponderation ) + 
      ( user.dotds_score.to_i * dotds_ponderation )
    end
  
    
  end