# initializer for PROD is not in source control, only on PROD server

if ENV['RAILS_ENV']!='production'
   Braintree::Configuration.environment = :sandbox
   Braintree::Configuration.merchant_id = "spcsmbyfxyd8qhnx"
   Braintree::Configuration.public_key = "5gh65sfg3fxc2bd6"
   Braintree::Configuration.private_key = "972c54f4066c275cfc8cf87f732b5d55"
# site: https://sandbox.braintreegateway.com/login
# login: share_your_wish 
# pasword: JHkmbkj567s? 
end
