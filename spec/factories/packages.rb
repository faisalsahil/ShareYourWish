# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :package do
    name "MyString"
    description "MyText"
    cost "9.99"
  end
end
