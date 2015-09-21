# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider 'facebook'
    uid { Faker::Internet.user_name }
    token { Faker::Lorem.characters(32) }
    association :user
  end
end
