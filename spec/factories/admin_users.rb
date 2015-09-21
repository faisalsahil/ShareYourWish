# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    remember_me true
  end
end
