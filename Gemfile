source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.8.3', '>= 7.0.8.3'
# Use postgresql as the database for Active Record
gem "pg", "1.3.5"
# Use Puma as the app server
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.6'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use SCSS to process CSS
gem 'sassc-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Load CSS framework
gem "spectre_scss"

# Add support for pagination on list pages
gem "will_paginate"

# Allow for easy (well, easier) CSS applied to HTML emails
gem "premailer-rails"

# Parse and traverse HTML pages
gem "nokogiri"

# Fetch data from 3rd party APIs
gem "faraday", "~> 2.2"
gem "faraday-net_http"

# Run the jobs for processing scoring data
gem "sidekiq", "~> 6.4", ">= 6.4.1"
gem "sidekiq-cron", "~> 1.3"

# Setup systematic migrations for data in addition to schema
gem "rails-data-migrations"

# Needed to fix a dependency loading issue; will hopefully be fixed somewhere
# in the future?
gem "net-http"

group :development, :test do
  gem "standard"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rails-controller-testing"
  gem "faker"
  gem "dotenv-rails"
  gem 'factory_bot_rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'listen'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem 'webdrivers'
  gem "webmock"
  gem 'simplecov', require: false
end

gem "dockerfile-rails", ">= 1.4", :group => :development
