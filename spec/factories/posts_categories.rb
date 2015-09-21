# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :posts_category do
    name { Faker::Lorem.words(3) }
    description { Faker::Lorem.sentence(5) }
  end
end
