# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence(3) }
    content { Faker::Lorem.sentence(5) }
    tag_list { Faker::Lorem.words(3).join(',') }
    author { Faker::Internet.user_name }
    association :posts_category
  end
end
