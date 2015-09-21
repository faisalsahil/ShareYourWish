require 'spec_helper'

describe State do
  specify { should have_many(:addresses) }
  subject { FactoryGirl.create(:state) }
  
  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
