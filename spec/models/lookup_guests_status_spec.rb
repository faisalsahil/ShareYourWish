require 'spec_helper'

describe LookupGuestsStatus do
  specify { should have_many(:guests) }
  specify { should be_valid}
  subject { FactoryGirl.create(:lookup_guests_status) }
end
