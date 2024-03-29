module ParieursHelper

  def annees_paris
    Pari.pluck(:created_at).map(&:year).uniq
  end


  # plus tard supprimer ce code qui n'est a priori plus utilisé que pour la verif solde quand depot pari
  # utiliser plutot les nouvelles methodes qui prennent les vals depuis la db plus efficaces

  #  def somme_paris_user(annee, users)

  def somme_paris_user(users)
    solde_depart =  5000 #500 - 5000 pour integrer les 10 semaines passées avec credit semaine, enlever crédit semaine
   # credit_semaine = 100
    #numero_semaine = Date.today.strftime('%W').to_i

   # somme_credit_semaine = credit_semaine * numero_semaine
  
    #start_date = DateTime.new(annee.to_i, 1, 1)
    #end_date = DateTime.new(annee.to_i, 12, 31)
  
    user_sum = {}
  
    users.each do |user|
      user_id = user.id
      user_paris = Pari.where(user_id: user_id)
                       # .where(created_at: start_date..end_date)
  
      montant_paris = user_paris.sum(:montant) #if user_paris.any?
      solde_paris = user_paris.sum(:solde) if user_paris.any?

      bonus_paris = user.bonus_paris.sum(:montant).to_i
  
      user_sum[user_id] = solde_depart + solde_paris.to_i - montant_paris.to_i + bonus_paris #+ somme_credit_semaine 
    end
  
    ranked_users = user_sum.sort_by { |_, sum| -sum }
  
    ranked_users_with_rank = {}
    ranked_users.each_with_index do |(user_id, sum), index|
      ranked_users_with_rank[user_id] = { rank: index + 1, sum: sum }
    end
  
    ranked_users_with_rank
  end  


 # def solde_paris(annee, user)
  def solde_paris(user)
    
   # solde_depart = 500
    solde_depart =  5000 #500 - 5000 pour integrer les 10 semaines passées avec credit semaine, enlever crédit semaine

   # credit_semaine = 100
   # numero_semaine = Date.today.strftime('%W').to_i
   # somme_credit_semaine = credit_semaine * numero_semaine
  
   # start_date = DateTime.new(annee.to_i, 1, 1)
   # end_date = DateTime.new(annee.to_i, 12, 31)
  
    user_id = user.id
    user_paris = Pari.where(user_id: user_id)
               #   .where(created_at: start_date..end_date)
  
    montant_paris = user_paris.sum(:montant) if user_paris.any?
    solde_paris = user_paris.sum(:solde) if user_paris.any?
    bonus_paris = user.bonus_paris.sum(:montant).to_i

    solde = solde_depart.to_i  + solde_paris.to_i - montant_paris.to_i + bonus_paris.to_i # + somme_credit_semaine.to_i
    solde
 
  end

  #  def ranked_parieurs(annee)

  def ranked_parieurs()
    users = User.includes(profile_pic_attachment: :blob).all
    sorted_users = users.sort_by { |user| -solde_paris(user) } #annee
    ranked_users = sorted_users.map do |user|
      {
        user: user,
        rank: sorted_users.index(user) + 1,
        solde_parieur: user.solde_paris.to_i
      }
    end
  end

  def top_1_parieur(annee)
    User.order(solde_paris: :desc).first
  end

  def icon_leader_parieur(user)
    top_parieur = top_1_parieur(Date.today.year).id
    user == top_parieur ? content_tag(:i, "", class: "fa fa-xl fa-sack-dollar mx-1 text-warning") : ""
  end
  
  def displayed_top_1_parieur(annee)
    parieur = top_1_parieur(annee)

    link_to user_path(parieur), class: "no-underline" do

      content_tag(:div, class: "record-with-effect d-flex align-items-center p-2") do
        concat image_tag(parieur.webp_variant, class: "mini-profile-pic me-2", alt: "user picture")
        concat content_tag(:span, parieur.short_name, class: "fw-bold") 
        concat content_tag(:span, number_to_human(parieur.solde_paris, units: { thousand: 'K', million: 'M', billion: 'B' }), class: "text-warning ms-2 me-1") 
        concat content_tag(:span, "pts paris", class: "text-warning")
        concat content_tag(:i, "", class: "fa fa-xl fa-sack-dollar mx-2 text-warning")
      end

    end
  end
  
end
