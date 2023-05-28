# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bcrypt', '~> 3.1.7'                 # bcrypt() is a sophisticated and secure hash algorithm designed by The OpenBSD project for hashing passwords. The bcrypt Ruby gem provides a simple wrapper for safely handling passwords.
gem 'bootsnap', require: false           # Boot large ruby/rails apps faster. Reduces boot times through caching; required in config/boot.rb
gem 'cssbundling-rails'                  # Bundle and process CSS with Tailwind, Bootstrap, PostCSS, Sass in Rails via Node.js.
gem 'factory_bot_rails', '~> 6.2'        # Test data generator -- see spec/support/factory_helper.rb
gem 'jbuilder'                           # Create JSON structures via a Builder-style DSL
gem 'jsbundling-rails'                   # Bundle and transpile JavaScript in Rails with esbuild, rollup.js, or Webpack.
gem 'pg', '~> 1.1'                       # Use postgresql as the database for Active Record# Use postgresql as the database for Active Record
gem 'puma', '~> 5.0'                     # Puma is a simple, fast, threaded, and highly parallel HTTP 1.1 server for Ruby/Rack applications.
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'    # Ruby on Rails is a full-stack web framework.
gem 'redis', '~> 4.0'                    # A Ruby client that tries to match Redis' API one-to-one, while still providing an idiomatic interface
gem 'sidekiq', '~> 7.1'                  # Background processing library
gem 'sidekiq-cron', '~> 1.10', '>= 1.10.1'
gem 'sprockets-rails'                    # Provides Sprockets implementation for Rails 4.x (and beyond) Asset Pipeline.Sprockets is a Ruby library for compiling and serving web assets
gem 'stimulus-rails'                     # A modest JavaScript framework for the HTML you already have.# A modest JavaScript framework for the HTML you already have.
gem 'turbo-rails'                        # The speed of a single-page web application without having to write any JavaScript.
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem

group :development, :test do
  gem 'awesome_print', '~> 1.8'                    # Nicely formatted data structures in console.
  gem 'debug', platforms: %i[mri mingw x64_mingw]  # Default Ruby 7 debugger
  gem 'faker', '~> 3.2'                            # Easy way to add fake data: names, email addresses, etc.
end

group :development do
  gem 'rubocop-rails', '~> 2.19', '>= 2.19.1', require: false      # A rubocop extension to support rails
  gem 'web-console'                                                # Access an IRB console on exceptions page/console
end

group :test do
  gem 'rspec-rails', '~> 6.0', '>= 6.0.2'     # rspec-rails is a testing framework for Rails 5+.
  gem 'rubocop-rspec', '~> 2.22'              # Code style checking for RSpec files
  gem 'shoulda-callback-matchers', '~> 1.1.4' # Matchers to test before, after and around hooks
  gem 'shoulda-matchers', '~> 5.3'            # Collection of testing matchers extracted from Shoulda http://thoughtbot.com/community
end
