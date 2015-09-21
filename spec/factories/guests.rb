# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    guest_access_token 1
    hidden false
    attendance { Guest::ATTENDANCES.keys[0] }
    association :event
    association :lookup_guests_status
    association :user
  end
end
