require 'spec_helper'

describe Comment do
  subject { FactoryGirl.create(:comment) }
  specify { should belong_to(:commentable) }
  specify { should belong_to(:guest) }
  specify { should belong_to(:user) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(Comment) }
end
