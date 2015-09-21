# Load the rails application
require File.expand_path('../application', __FILE__)
  
ActionMailer::Base.smtp_settings = {
 :user_name => "sywmailer",
 :password => "sirmailalot",
 :domain => "shareyourwish.com",
 :address => "smtp.sendgrid.net",
 :port => 587,
 :authentication => :plain,
 :enable_starttls_auto => true
}


APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/config.yml")[Rails.env]

# Initialize the rails application
Shareyourwish::Application.initialize!
