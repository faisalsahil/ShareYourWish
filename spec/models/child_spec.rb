require 'spec_helper'

describe Child do
  subject { FactoryGirl.create(:child) }
  specify { should belong_to(:guest) }
  specify { should belong_to(:event) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(Child) }

  describe "validation" do
    
    it "shouldn't be saved without :name" do
      subject.name = nil
      subject.should_not be_valid
    end

    it "shouldn't be saved with :dob after Time.now" do
      subject.should_not allow_value(Date.today + 1.day).for(:dob)
    end
  end

end

