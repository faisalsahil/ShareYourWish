# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company_name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    postal_code { Faker::Address.postcode }
    association :state
    association :user
  end
end