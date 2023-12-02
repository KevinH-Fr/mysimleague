Stripe.api_key = if Rails.env.production?
    ENV['STRIPE_SECRET_KEY'] # Use environment variable for production
  else
    stripe_secret_key = Rails.application.credentials.dig(:stripe_secret_key)
  end
  