class StripeController < ApplicationController
  def purchase_success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if session.payment_status == 'paid'
      article_id = session.metadata.article_id
      @article = Article.find(article_id)

      subscription_id = @article.abonnement ? session.subscription : nil

      Purchase.find_or_create_by(user: current_user, article: @article, stripe_ref: subscription_id ) do |purchase|
        purchase.status = 'paid'
      end

      # creer une table bonus_pari : user:references, montant:intger

      puts "______________ call crea bonus pari_______________________"
      bonus_pari = BonusPari.new(
        user: current_user,
        montant: @article.bonus_paris
      )

            # Save the Pari record
            if bonus_pari.save
              puts "Pari record created successfully"
            else
              puts "Failed to create Pari record"
            end

    end

  end
end
