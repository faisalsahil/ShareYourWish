# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title { Faker::Lorem.sentence(5) }
    event_date {Date.today + 30.days}
    start_time '12:02:30'
    end_time '14:02:30'
    charity_donation_percent 0.75
    child_full_name { Faker::Name.name }
    host_name { Faker::Name.name }
    child_dob {Date.today - 12.years}
    child_pronoun 'female'
    page_content_one { Faker::Lorem.paragraph(3) }
    page_content_two { Faker::Lorem.paragraph(4) }
    page_content_three { Faker::Lorem.paragraph(2) }
    page_content_four { Faker::Lorem.paragraph(2) }
    other_page_content { Faker::Lorem.paragraph(1) }
    parental_consent_status 'notConfirmed'
    page_customization_hash { Faker::Lorem.characters(32) }
    magic_phrase { Faker::Internet.domain_word }
    location_name { Faker::Lorem.sentence(3) }
    location_address { Faker::Address.street_address }
    status 'in_progress'
    state 'open'
    step { Step.first }
    rsvp_by { Date.today + 15.days }
    theme_code 'default'
    association :package
    association :user
    charities {FactoryGirl.create_list(:charity, 2)}
  end
end
