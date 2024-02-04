# lib/tasks/your_namespace.rake
namespace :your_namespace do
    desc 'Give monthly bonus points to subscribed users'
    task give_monthly_bonus_points: :environment do
      # Check if it's the 1st day of the month
    #  return unless Date.today.day == 1
  
      # Get all subscribed users with paid status
      subscribed_users = Purchase.where(status: "paid")
  
      # Iterate through each user and give bonus points based on the article's bonus_paris
      subscribed_users.each do |purchase|
        article = purchase.article
        BonusPari.create(user_id: purchase.user_id, montant: article.bonus_paris)
      end
    end
  end
  