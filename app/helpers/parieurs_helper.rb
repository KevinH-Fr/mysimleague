module ParieursHelper

  def annees_paris
    Pari.pluck(:created_at).map(&:year).uniq
  end

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
  
end
