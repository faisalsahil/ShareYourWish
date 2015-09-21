# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lookup_event_sequence do
    code 'setup_event'
    friendly_text "Setup Event"
  end
end
