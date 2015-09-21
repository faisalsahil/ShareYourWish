require 'spec_helper'

describe Address do
  specify { should belong_to(:user) }
  specify { should belong_to(:state) }
  subject { FactoryGirl.create(:address) }

  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
