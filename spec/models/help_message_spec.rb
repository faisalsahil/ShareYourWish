require 'spec_helper'

describe HelpMessage do
  subject { FactoryGirl.create(:help_message) }
  specify { should be_valid }
  specify { should validate_presence_of(:code) }
  specify { should validate_presence_of(:text) }
  specify { should validate_uniqueness_of(:code) }
  specify { should be_persisted }
  specify { should be_an_instance_of(HelpMessage) }
end
