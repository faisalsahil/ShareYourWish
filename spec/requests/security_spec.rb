require 'spec_helper'

describe "Security" do
  describe "outdoor" do
    it "cross domain ajax shouldn't work" do
      visit root_url(:host => '127.0.0.0:3000')
      current_url.should eq(root_url(:host => '127.0.0.0:3000'))
      guest = FactoryGirl.create(:guest)
      delete guest_url(guest, :host => '127.0.0.0:3000')
      guest.should be_persisted
    end

    it "shouldn't brake site throught contact form using" do
      feedback = FactoryGirl.create(:feedback)
      sql_inject = %{\'; DROP TABLE feedbacks; --}
      javascript_inject = %{sfgdgsg
        <script>alert('Hello');</script>
        <script>document.write(document.cookie);</script>
        dsfgdsgfsdg}
      visit contact_us_path
      current_url.should eq(contact_us_url)
      page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      page.should have_selector('h1:contains("Contact Us")')
      page.fill_in "feedback_name", with: sql_inject
      page.fill_in "feedback_email", with: feedback.email
      page.fill_in "feedback_title", with: javascript_inject
      page.fill_in "feedback_message", with: sql_inject
      click_button "Submit"
      current_url.should eq(root_url)
      page.should have_selector('div.flash.notice:contains("Your feedback was received - thanks for contacting us.")')
    end
    
    it "shouldn't brake site throught sign in form using" do
      user = FactoryGirl.create(:user)
      sql_inject = %{\'; DROP TABLE feedbacks; --}
      javascript_inject = %{sfgdgsg
        <script>alert('Hello');</script>
        <script>document.write(document.cookie);</script>
        dsfgdsgfsdg}
        visit new_user_session_url
        page.fill_in "user_email", with: user.email
        page.fill_in "user_password", with: sql_inject
        click_button "Sign In"
        current_url.should eq(new_user_session_url)
        page.fill_in "user_email", with: user.email
        page.fill_in "user_password", with: javascript_inject
        click_button "Sign In"
        current_url.should eq(new_user_session_url)
        page.should have_selector('div.flash.alert:contains("Invalid email or password.")')
    end
  end
    
  describe "indoor" do
    
    let :user do
      FactoryGirl.create(:user)
    end
    let :event do
      FactoryGirl.create(:event, :user => user)
    end
    
    it "shouldn't get access to event data without authorization" do
      FactoryGirl.create(:guest, :id => Guest::ANONYMOUS_ID)
      visit events_path
      current_url.should eq(new_user_session_url)
      page.should have_selector('div.flash.alert:contains("You need to sign in or sign up before continuing.")')
      visit event_path(event.id)
      current_url.should eq(visitor_entrance_event_url(event.id))
      delete event_path(event.id)
      event.should be_persisted
    end
    
    it "should be able edit/delete own event authorized"
    it "shouldn't be able edit/delete not own event authorized"
    
    it "user shouldn't be able to edit users fields" do
      user.update_attribute(:full_name, 'Correct')
      lambda { 
        delete("/users/#{user.id}") 
      }.should raise_error
      user.should be_persisted
      lambda { 
        put "/users/#{user.id}", :user => { :full_name => "Fail", :role => :admin }
      }.should raise_error
      user.reload
      user.full_name.should eql 'Correct'
      user.role.should eql "user"
    end
    
    it "user shouldn't be able to edit/delete not own guests"
    it "user shouldn't be able edit something without form (using ajax from console)"
  end
end