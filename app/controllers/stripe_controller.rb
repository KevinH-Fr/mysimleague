class StripeController < ApplicationController
  def purchase_success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if session.payment_status == 'paid'
      article_id = session.metadata.article_id
      @article = Article.find(article_id)

<<<<<<< HEAD
      subscription_id = @article.abonnement ? session.subscription : nil

      Purchase.find_or_create_by(user: current_user, article: @article, stripe_ref: subscription_id ) do |purchase|
=======
      Purchase.find_or_create_by(user: current_user, article: @article) do |purchase|
>>>>>>> 80d0890a66bc88f960c4cd1623feccce0f317536
        purchase.status = 'paid'
      end
    end

  end
end
