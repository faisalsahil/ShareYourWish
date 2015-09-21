# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :help_message do
    code { Faker::Internet.domain_word }
    text { Faker::Lorem.sentence(5) }
  end
end
