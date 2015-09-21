require 'spec_helper'
# save_and_open_page
# print page.html
# page.save_screenshot('screenshot.png')
describe "Authentication" do

  subject { FactoryGirl.create(:user) }

  it "should sign up" do
    user = FactoryGirl.build(:user)
    sign_up user
    current_url.should eq(root_url)
    User.find_by_email(user.email).present?.should be_true
    page.should have_selector('div.flash.notice:contains("Welcome! You have signed up successfully.")')
  end
 
  it "should sign in" do
    sign_in subject
    current_url.should eq(root_url)
    page.should have_selector('div.flash.notice:contains("Signed in successfully.")')
  end

  it "should sign out" do
    sign_in subject
    sign_out
    current_url.should eq(root_url)
    page.should have_selector('div.flash.notice:contains("Signed out successfully.")')
  end

end
