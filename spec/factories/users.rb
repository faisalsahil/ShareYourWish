# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
      email { Faker::Internet.email }
      password '123456'
      password_confirmation '123456'
      #remember_me false
      full_name { Faker::Name.name }
      user_name { Faker::Internet.user_name }
      role 'user'
      is_under_age false
      language 'ru'
      terms_of_use true
  end
end