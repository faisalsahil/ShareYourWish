# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_transaction_log do
    event_transaction_log_category_id 101
    description { Faker::Lorem.sentence(5) }
    memo { Faker::Lorem.sentence(3) }
    event_fund 1.99
    gift_fund 2.99
    donation_fund 3.99
    syw_fund 4.99
    association :contribution
    association :event
    association :payment
    association :charity
  end
end
