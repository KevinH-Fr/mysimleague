class BonusPariJob < ApplicationJob
    queue_as :default
  
    def perform

      # verifier si ok 
      return unless Date.today.day == 1 # Execute only on the 1st day of the month

      # Get all subscribed users
      subscribed_users = Purchase.where(status: "paid")
  
      # Iterate through each user and give the bonus points based on the article's bonus_paris
      subscribed_users.each do |purchase|
        article = purchase.article

        if article.abonnement
          BonusPari.create(user_id: purchase.user_id, montant: article.bonus_paris)
        end
      end

    end
  end
  