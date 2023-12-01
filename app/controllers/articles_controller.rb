class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy, :create_checkout_session]

  def new
    @article = Article.new
  end

  def create
    
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save

        create_stripe_product_and_price(@article)

        flash.now[:success] = "article was successfully created"

        format.html { redirect_to article_url(@article), notice: "article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
   
    respond_to do |format|
      format.html
    end

  end

  def update
    if @article.update(article_params)
      update_stripe_product_and_price(@article)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def create_checkout_session
    session = Stripe::Checkout::Session.create({
      metadata: {
        article_id: @article.id,
        image_url: @article.image.url  
 
      },

      customer_email: current_user.email,
      line_items: [
        {
          price: @article.stripe_price_id,
          quantity: 1,
        }
      ],
      mode: 'subscription',
      success_url: root_url + "purchase_success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:  article_url(@article),
    })

    redirect_to session.url, allow_other_host: true, status: 303

  end

  def index
    @articles = Article.all
  end
  

  def destroy
    @article.destroy

    respond_to do |format|
      flash.now[:success] = "article was successfully destroyed"

      format.html { redirect_to articles_url, notice: "article was successfully destroyed." }
      format.json { head :no_content }

    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:titre, :content, :montant, :image)
    end

    def create_stripe_product_and_price(article)
      # Create a product in Stripe
      product = Stripe::Product.create(name: article.titre, type: 'service')
  
      # Create a price for the product
      price = Stripe::Price.create({
        product: product.id,
        unit_amount: (article.montant * 100).to_i,  # Convert to cents
        currency: 'eur',
        recurring: {interval: 'month'},  # Adjust based on your subscription model
      })
  
      # Save the Stripe product and price IDs in the article
      article.update(stripe_product_id: product.id, stripe_price_id: price.id)
    end

    def update_stripe_product_and_price(article)
      return unless article.stripe_product_id && article.stripe_price_id
  
      # Retrieve the existing Stripe product
      stripe_product = Stripe::Product.retrieve(article.stripe_product_id)
  
      # Create a new Stripe price for the product
      new_price = Stripe::Price.create({
        product: stripe_product.id,
        unit_amount: (article.montant * 100).to_i,
        currency: 'usd',
        recurring: {interval: 'month'},
      })
  
      # Update the article with the new Stripe price ID
      article.update(stripe_price_id: new_price.id)
    end

end
