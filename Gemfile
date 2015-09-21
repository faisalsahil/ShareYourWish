source 'http://rubygems.org'
source 'http://gems.github.com'

gem 'rails', '3.2.11'
gem 'mysql2'
gem 'json'
gem 'haml'
gem "formtastic", "~> 2.1.1"
gem "activeadmin", "~> 0.4.3"
gem 'jquery-rails'
gem 'paperclip'
gem 'will_paginate', '~> 3.0.3'
gem "friendly_id", "~> 4.0.1"
gem 'best_in_place'
gem 'tinymce-rails'
gem 'date_validator'
gem 'paranoia'
gem 'jquery-fileupload-rails', '~> 0.4.1'
gem 'acts-as-taggable-on', '~> 2.3.1'
gem 'activemerchant'
gem 'braintree', '>= 2.16.0'
gem 'validates_as_postal_code'
gem 'numbers_and_words'

# Handling cron jobs
gem 'whenever'
gem 'sitemap_generator'

# Auth
gem 'omniauth', ">=0.2.6"
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-identity'
gem 'devise', ">=1.4.2"
gem 'cancan'
gem 'fb_graph'

# PDF
gem 'prawn'

# Comments
gem 'acts_as_commentable', '2.0.1'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# web server, deployment, monitoring
gem 'thin', "~> 1.5.0"
gem 'turbo-sprockets-rails3'
gem 'capistrano'
gem "airbrake"
gem 'newrelic_rpm'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '~> 1.3.0'
  gem 'therubyracer', '~> 0.11.3', :platforms => :ruby
end

group :development, :test do
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false # need?
  gem 'cucumber-websteps', :require => false # need?
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  # gem 'capybara-webkit'
  gem 'nokogiri'
  gem 'guard'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'watchr'
  # gem 'debugger'
  gem 'spork'
  gem 'rb-fsevent'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  gem 'guard-livereload'
  gem 'faker'
  gem 'certified' # mac ssl error fix
  gem 'seed_dump'
  gem 'mocha', require: false
  gem 'letter_opener'
end

# Specifically for enkiBlog, but may use for other site features too
#gem 'RedCloth', '~> 4.2.9', :require => 'redcloth'		#  Textile markup for Ruby
#gem 'lesstile'
#gem 'coderay'
#gem 'aaronh-chronic', :require => 'chronic' # Fixes for 1.9.2		# Natural language date parser
#gem 'exception_notification', '~> 2.5.2'   # exception notification by email for Rails
#platforms :jruby do
#gem 'activerecord-jdbcsqlite3-adapter'
#gem 'trinidad'
#gem 'jruby-openssl'
#end
