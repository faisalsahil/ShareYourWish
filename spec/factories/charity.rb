# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charity do
    name { Faker::Company.name }
    name_alias { Faker::Internet.user_name }
    description { Faker::Lorem.sentence(5) }
    city { Faker::Address.city }
    region { Faker::Address.state }
    website_url { Faker::Internet.domain_name }
    association :lookup_charity_code
    association :picture
  end
end
