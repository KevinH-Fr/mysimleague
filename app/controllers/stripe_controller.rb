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
    end

  end
end
