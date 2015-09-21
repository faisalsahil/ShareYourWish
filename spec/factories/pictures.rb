# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    imageable_type "MyString"
    imageable_id 1
    sort_order 1
    layout_section "MyString"
    layout_slot 1
    image { File.new(Rails.root + 'spec/factories/images/_56kb_size_jpg.jpg') }
  end
end
