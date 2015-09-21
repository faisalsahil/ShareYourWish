# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :child do
    name { Faker::Name.name }
    dob {Date.today - 30.days}
    association :guest
    association :event
  end
end
