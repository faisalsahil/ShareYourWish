require 'spec_helper'

describe CharitiesHelper do
  
  describe "methods" do
    
    subject { stub(:id => 132, :name => Faker::Lorem.sentence(4), :description => Faker::Lorem.sentence(5), :website_url => nil) }
    
    it "#short_description" do
      helper.short_description(subject, 220).should eql subject.description
      description = 'Magnam fugiat natus et minus nulla quo consequatur sapiente iusto at porro enim itaque aspernatur ea ut laborum veritatis quis autem iste voluptatem in sit aperiam explicabo facilis.'
      subject { stub(:description => description) }
      helper.short_description(subject, 80).should eql subject.description
    end
    
    it "#website" do
      subject.website_url.present?.should be_false
      helper.website(subject).should eql '(not provided)'
      subject.stubs(:website_url => 'website_url')
      helper.website(subject).should eql '<a href="website_url">website_url</a>'
    end
    
    it "#two_lines_description" do
      charity = mock_model(Charity, :id => 132)
      charity.stubs(:name => Faker::Lorem.sentence(4), :description => 'Magnam fugiat natus et minus nulla quo consequatur sapiente iusto at porro enim itaque aspernatur ea ut laborum veritatis quis autem iste voluptatem in sit aperiam explicabo facilis.')
      helper.two_lines_description(charity).should eql 'Magnam fugiat natus et minus nulla quo consequatur sapiente iusto at porr ...(<a href="/charity/132" charity_id="132" class="charity_details">more</a>)'
    end

  end
  
end
