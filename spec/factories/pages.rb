# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title { Faker::Lorem.sentence(3) }
    teaser { Faker::Lorem.sentence(5) }
    text { Faker::Lorem.paragraph(3) }
    slug { Faker::Internet.domain_word }
    order 1
    show_in_menu false
  end
end
