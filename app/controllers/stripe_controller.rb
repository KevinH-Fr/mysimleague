class StripeController < ApplicationController
  def purchase_success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if session.payment_status == 'paid'
      article_id = session.metadata.article_id
      @article = Article.find(article_id)

      Purchase.find_or_create_by(user: current_user, article: @article) do |purchase|
        purchase.status = 'paid'
      end
    end

    
  end
end
