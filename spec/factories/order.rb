# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    association :user
    association :event
    association :billing_address, :factory => :address
    association :shipping_address, :factory => :address
    tax_total_cost 3.5
    shipping_total_cost 12
    adjustments_total_cost 5
  end
end
