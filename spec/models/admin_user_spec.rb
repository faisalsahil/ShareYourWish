require 'spec_helper'

describe AdminUser do
  specify { should validate_presence_of(:email) }
  specify { should validate_presence_of(:password) }
  subject { FactoryGirl.create(:admin_user) }

  describe "validation" do
    it "should be valid" do
      subject.should be_valid
    end
  end
end
