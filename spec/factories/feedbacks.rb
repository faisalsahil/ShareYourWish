# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    title { Faker::Lorem.sentence(3) }
    message { Faker::Lorem.sentence(5) }
  end
end
