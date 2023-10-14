source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "sqlite3", "~> 1.4"
end

group :production do
  gem 'pg', '~> 1.4', '>= 1.4.1'
end


group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

#gem "devise", "~> 4.9"
gem 'devise', github: "heartcombo/devise", branch: "main"

gem 'requestjs-rails'
gem 'jquery-rails'
gem 'wicked_pdf'

gem "wkhtmltopdf-binary", group: :development
gem "wkhtmltopdf-heroku", group: :production

gem 'imgkit'
gem 'wkhtmltoimage-binary'
gem 'activeadmin'
gem 'sassc-rails'
gem 'cloudinary'

gem 'dotenv-rails', groups: [:development, :test]

gem 'open-weather-ruby-client'
gem 'active_analytics'
gem 'sitemap_generator'

gem "local_time"

gem "image_processing", "~> 1.2"

gem 'pagy'

gem 'bullet', group: 'development'

gem 'meta-tags'

#gem 'faker'

#gem 'impressionist'

#gem "ahoy_matey"