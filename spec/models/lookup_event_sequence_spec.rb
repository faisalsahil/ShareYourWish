require 'spec_helper'

describe LookupEventSequence do
  specify { should have_many(:events) }
  specify { should validate_presence_of(:code) }
  specify { should validate_presence_of(:sequence) }
  specify { should validate_presence_of(:friendly_text) }
  subject { FactoryGirl.create(:lookup_event_sequence) }

  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
