# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lookup_charity_code do
    ntee_code { Faker::Lorem.characters(3) }
    title { Faker::Lorem.sentence(2) }
  end
end
