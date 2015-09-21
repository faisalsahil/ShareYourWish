require 'spec_helper'

describe Page do
  subject { FactoryGirl.create(:page) }
  specify { should validate_presence_of(:title) }
  specify { should validate_presence_of(:text) }
  specify { should validate_presence_of(:slug) }
  specify { should validate_presence_of(:order) }
  specify { should ensure_length_of(:title).is_at_least(2).is_at_most(255) }
  specify { should validate_numericality_of(:order) }
  specify { should validate_uniqueness_of(:slug) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(Page) }
end
