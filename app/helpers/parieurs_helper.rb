module ParieursHelper

  def annees_paris
    Pari.pluck(:created_at).map(&:year).uniq
  end


  # plus tard supprimer ce code qui n'est a priori plus utilisé que pour la verif solde quand depot pari
  # utiliser plutot les nouvelles methodes qui prennent les vals depuis la db plus efficaces
  def somme_paris_user(annee, users)
    solde_depart = 500
    credit_semaine = 100
    numero_semaine = Date.today.strftime('%W').to_i
    somme_credit_semaine = credit_semaine * numero_semaine
  
    start_date = DateTime.new(annee.to_i, 1, 1)
    end_date = DateTime.new(annee.to_i, 12, 31)
  
    user_sum = {}
  
    users.each do |user|
      user_id = user.id
      user_paris = Pari.where(user_id: user_id)
                        .where(created_at: start_date..end_date)
  
      montant_paris = user_paris.sum(:montant) #if user_paris.any?
      solde_paris = user_paris.sum(:solde) if user_paris.any?
  
      user_sum[user_id] = solde_depart + somme_credit_semaine + solde_paris.to_i - montant_paris.to_i
    end
  
    ranked_users = user_sum.sort_by { |_, sum| -sum }
  
    ranked_users_with_rank = {}
    ranked_users.each_with_index do |(user_id, sum), index|
      ranked_users_with_rank[user_id] = { rank: index + 1, sum: sum }
    end
  
    ranked_users_with_rank
  end  


  def solde_paris(annee, user)
    
    solde_depart = 500
    credit_semaine = 100
    numero_semaine = Date.today.strftime('%W').to_i
    somme_credit_semaine = credit_semaine * numero_semaine
  
    start_date = DateTime.new(annee.to_i, 1, 1)
    end_date = DateTime.new(annee.to_i, 12, 31)
  
    user_id = user.id
    user_paris = Pari.where(user_id: user_id)
                  .where(created_at: start_date..end_date)
  
    montant_paris = user_paris.sum(:montant) #if user_paris.any?
    solde_paris = user_paris.sum(:solde) if user_paris.any?
  
    solde = solde_depart.to_i + somme_credit_semaine.to_i + solde_paris.to_i - montant_paris.to_i
    solde
 
  end


  def ranked_parieurs(annee)
    users = User.includes(profile_pic_attachment: :blob).all
    sorted_users = users.sort_by { |user| -solde_paris(annee, user) }
    ranked_users = sorted_users.map do |user|
      {
        user: user,
        rank: sorted_users.index(user) + 1,
        solde_parieur: user.solde_paris
      }
    end
  end

  def top_1_parieur(annee)
    #ranked_parieurs(annee).first
    User.order(solde_paris: :desc).first

  end

  def icon_leader_parieur(annee, user)
    top_parieur = top_1_parieur(Date.today.year).id
    user == top_parieur ? content_tag(:i, "", class: "fa fa-xl fa-sack-dollar me-2 text-warning") : ""
  end
  
  
end
