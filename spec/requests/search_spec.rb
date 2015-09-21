require 'spec_helper'

describe "Search" do
  describe "from root" do
    it "should work" do
      keyword = 'find me'
      FactoryGirl.create(:event)
      FactoryGirl.create(:event)
      FactoryGirl.create(:event, :title => keyword)
      FactoryGirl.create(:event, :location_name => keyword)
      FactoryGirl.create(:event, :child_full_name => keyword)
      visit root_path
      page.should have_selector('form#search_form #q')
      fill_in "q", with: keyword
      click_button('search-box-click')
      current_path.should eq(search_path)
      page.should have_selector("div.event-item-title:contains('#{keyword}')")
    end
  end
end
