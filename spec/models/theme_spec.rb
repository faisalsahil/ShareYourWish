require 'spec_helper'

describe Theme do
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(Theme) }
  subject { FactoryGirl.create(:theme) }
end
