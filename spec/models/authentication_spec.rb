require 'spec_helper'

describe Authentication do
  specify { should belong_to(:user) }
  subject { FactoryGirl.create(:authentication) }
  
  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
