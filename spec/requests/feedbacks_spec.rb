require 'spec_helper'

describe "Feedbacks" do
  describe "GET /feedbacks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get feedbacks_path
      response.status.should be(302)
    end
  end

  describe "Leave feedback as guest on page contact-us" do
    subject { FactoryGirl.build(:feedback) }
    it "should work" do 
      visit contact_us_path
      current_url.should eq(contact_us_url)
      page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      page.should have_selector('h1:contains("Contact Us")')
      page.fill_in "feedback_name", with: subject.name
      page.fill_in "feedback_email", with: subject.email
      page.fill_in "feedback_title", with: subject.title
      page.fill_in "feedback_message", with: subject.message
      click_button "Submit"
      current_url.should eq(root_url)
      page.should have_selector('div.flash.notice:contains("Your feedback was received - thanks for contacting us.")')
    end
  end
end
