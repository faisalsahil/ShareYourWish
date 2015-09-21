# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_activity_log do
    message "MyText"
    is_internal false
  end
end
