source "https://rubygems.org"

gem "rails", "~> 8.1.3", ">= 8.1.3.1"
gem "puma", ">= 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem 'pg'


# Use modern assets stuff
gem 'vite_rails'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "bootsnap", require: false
gem "kamal", require: false
gem "image_processing", "~> 1.2"

gem "devise", "~> 5.0"
gem "view_component"

group :development, :test do
  gem "dotenv"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'simplecov', require: false
end
