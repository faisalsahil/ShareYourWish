require 'spec_helper'

describe Charity do
  specify { should have_one(:picture) }
  specify { should belong_to(:lookup_charity_code) }
  specify { should have_many(:contributions) }
  specify { should have_many(:event_transaction_logs) }
  specify { should validate_presence_of(:name) }
  subject { FactoryGirl.create(:charity) }

  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
