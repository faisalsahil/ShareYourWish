require 'spec_helper'

describe Post do
  subject { FactoryGirl.create(:post) }
  specify { should validate_presence_of(:title) }
  specify { should validate_presence_of(:content) }
  specify { should validate_presence_of(:author) }
  specify { should validate_presence_of(:slug) }
  specify { should validate_presence_of(:posts_category) }
  specify { should belong_to(:posts_category) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(Post) }

  describe "scopes" do
    it "should provide a by_updated scope" do
      scope = Post.by_updated
      scope.order_values.should include(:updated_at)
    end
  end

  context "tags" do
    it 'should add tags to post' do
      tags = %w{awesome slick hefty}
      subject.tag_list = tags.join(',')
      subject.save
      subject.reload
      subject.tags.count.should eql 3
      subject.tag_list.should eql tags
      Post.tagged_with(tags, :match_all => true).first.should eql subject
    end
  end
end
