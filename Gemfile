source "https://rubygems.org"

gem "rails", "~> 8.1.2"
gem "propshaft"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"

# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"

gem 'simple_form'
gem 'slim-rails'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

  gem "sqlite3", ">= 2.1"
  gem 'faker'
  gem 'minitest-power_assert'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'slim_lint'
  gem 'dotenv-rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'rails-controller-testing'
end

group :production do
  gem 'pg'
end
