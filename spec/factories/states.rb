# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state do
    name { Faker::Address.state }
    abbr { Faker::Address.state_abbr }
  end
end
