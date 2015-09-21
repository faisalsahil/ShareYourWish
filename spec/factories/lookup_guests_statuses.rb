# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lookup_guests_status do
    status_code "inviteNotSent"
    friendly_text "Invitation not yet sent"
  end
end
