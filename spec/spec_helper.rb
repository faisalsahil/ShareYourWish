# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/rails'
require 'cancan/matchers'

require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

Spork.each_run do
  # This code will be run each time you run your specs.
end

if Spork.using_spork?
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  
  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    load 'db/seeds.rb'
  end
  
  config.before(:all) do
    DatabaseCleaner.start
  end
  
  config.after(:all) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  config.mock_framework = :rspec
end

def sign_out
  visit root_path
  click_link "Sign Out"
end

def sign_in user 
  visit new_user_session_url
  page.fill_in "user_email", with: user.email
  page.fill_in "user_password", with: user.password
  click_button "Sign In"
end  

def sign_up user
  visit root_path
  click_link "Sign Up / Log In"
  current_url.should eq(new_user_session_url)
  click_link "Sign Up"
  visit new_user_registration_url
  page.fill_in "user_full_name", with: user.full_name
  page.fill_in "user_email", with: user.email
  page.fill_in "user_password", with: user.password
  page.fill_in "user_password_confirmation", with: user.password
  find(:css, "#user_terms_of_use").set(true)
  click_button "Sign Up"
end
