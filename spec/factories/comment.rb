# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    content { Faker::Lorem.sentence(5) }
    visible true
    association :guest
    association :user
    commentable_type 'Event'
    commentable_id :event
  end
end
