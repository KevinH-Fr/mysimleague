
Cloudinary.config do |config|
    config.cloud_name = 'dukne3lhz'
    config.api_key = ENV['CLOUDINARY_KEY']
    config.api_secret = ENV['CLOUDINARY_SECRET']
    config.secure = true # Optional, ensures HTTPS URLs
    # Add more configuration options as needed
  end
  