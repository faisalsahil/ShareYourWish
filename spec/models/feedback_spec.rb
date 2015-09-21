require 'spec_helper'

describe Feedback do
  subject { FactoryGirl.create(:feedback) }
  specify { should belong_to(:user) }
  specify { should validate_presence_of(:name) }
  specify { should validate_presence_of(:email) }
  specify { should validate_presence_of(:title) }
  specify { should validate_presence_of(:message) }
  specify { should be_valid }
end
