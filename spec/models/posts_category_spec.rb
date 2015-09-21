require 'spec_helper'

describe PostsCategory do
  subject { FactoryGirl.create(:posts_category) }
  specify { should validate_presence_of(:name) }
  #specify { should validate_presence_of(:sequence) }
  #specify { should validate_numericality_of(:sequence) }
  specify { should have_many(:posts) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(PostsCategory) }
end
