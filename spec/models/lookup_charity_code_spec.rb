require 'spec_helper'

describe LookupCharityCode do
  specify { should have_many(:charities) }
  subject { FactoryGirl.create(:lookup_charity_code) }

  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
