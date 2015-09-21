require 'spec_helper'

describe Cart do
  specify { should belong_to(:user) }
  specify { should belong_to(:event) }
  specify { should have_many(:line_items) }
  subject { FactoryGirl.create(:cart) }

  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end 
