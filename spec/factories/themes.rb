# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :theme do
    code "new"
    friendly_name "New"
    is_premium false
    cost 0.0
  end
end
