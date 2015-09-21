# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    amount 11
    anonymous false
    association :charity
    association :guest
    association :event
  end
end
