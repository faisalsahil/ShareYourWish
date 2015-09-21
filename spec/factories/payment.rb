# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    amount 11
    payment_method { Payment::PAYMENT_METHODS[0] }
    cc_num 4111111111111111
    cc_exp_month "12"
    cc_exp_year "2015"
    cc_cvv 123
    cc_postal_code { Faker::Address.zip_code }
    processing_response { Payment::PROCESSING_RESPONSES.keys[0] }
  end
end
