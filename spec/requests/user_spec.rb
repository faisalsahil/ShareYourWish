require 'spec_helper'

# save_and_open_page

describe "User" do

  describe "abilities" do

    subject { ability }

    describe "Visitors" do
      include GuestsHelper
      let(:visitor){ FactoryGirl.build(:user, :role => 'visitor') }
      let(:ability){ Ability.new(visitor) }

      it "should be able to see the home page without authorization" do
        ability.should be_able_to( :read, :page)
        visit root_path
        current_url.should eq(root_url)
      end

      it "should be able to navigate to links on the home page without authorization (e.g. Blog, Contact Us, all Footer links)" do
        subject.should be_able_to( :read, :page)
        ['about-us','mission','team','press','terms-of-service','privacy-policy','site-map'].each do |page|
          visit pages_url(:page => page)
          current_url.should eq(pages_url(:page => page))
        end
        visit posts_path
        current_url.should eq(posts_url)
      end

      it "should be able to register as new Users" do
        sign_up visitor
        current_url.should eq(root_url)
        user = User.find_by_email(visitor.email)
        user.present?.should be_true
        visitor.is?(:visitor).should be_true
        user.is?(:user).should be_true
      end

      it "should not be able to viev events page" do
        visit events_path
        current_url.should eq(new_user_session_url)
        page.should have_selector('div.flash.alert:contains("You need to sign in or sign up before continuing.")')
        visit events_path Event.last
        current_url.should eq(new_user_session_url)
        page.should have_selector('div.flash.alert:contains("You need to sign in or sign up before continuing.")')
      end

      it "should be able to view invite events page" do
        event = FactoryGirl.create(:event)
        guest = FactoryGirl.create(:guest, :event => event)
        subject.should be_able_to( :invite, Event )
        visit invite_path(guest)
        current_path.should eq(event_guest_show_path(:slug => event.slug, :guest_id => guest.id, :guest_access_token => guest.guest_access_token))
        page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      end

      it "should not be able to view invite events page with wrong guest_access_token" do
        guest = FactoryGirl.create(:guest)
        wrong_invite_path = event_guest_invite_path(:slug => guest.event.slug, :guest_id => guest.id, :guest_access_token => Faker::Lorem.characters(32))
        visit wrong_invite_path
        current_url.should eq(root_url)
        page.should have_selector('div.flash.notice:contains("Sorry, there was an error accessing this event using the guest token")')
      end

      it "should be able to leave comments on invite events page"

      it "should be able to leave feedbacks on contact-us page" do
        ability.should be_able_to( :create, Feedback)
        visit contact_us_path
        current_url.should eq(contact_us_url)
      end

      it "should be able to read or edit feedbacks" do
        feedback = FactoryGirl.create(:feedback)
        ability.should_not be_able_to( :manage, Feedback)
        ability.should_not be_able_to( :read, Feedback)
        visit feedbacks_path
        current_url.should eq(root_url)
        page.should have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
        visit feedbacks_path(feedback)
        current_url.should eq(root_url)
        page.should have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      end

      it "should be able to create contributions" do
        ability.should be_able_to( :create, Contribution)
      end
    end

    describe "New Users" do
      let(:user){ FactoryGirl.build(:user)}
      let(:ability){ Ability.new(user) }

      it "should see a message after registration 'Thank you for requesting access to our...'" do
        sign_up user
        current_url.should eq(root_url)
        User.find_by_email(user.email).present?.should be_true
        user.is?(:user).should be_true
      end

      it "must wait for admin authorization to access the rest of the site as Beta testers" do
        user.is?(:user).should be_true
        event = FactoryGirl.create(:event, :user => user)
        sign_in user
        ability.should_not be_able_to( :read, event )
        user.role = 'tester'
        ability = Ability.new(user)
        ability.should be_able_to( :read, event )
      end

    end

    describe "Beta-authorized Users" do
      let(:tester){ FactoryGirl.create(:user, :role => 'tester')}
      let(:ability){ Ability.new(tester) }

      it "should can log in and access the entire site" do
        tester.is?(:tester).should be_true
        sign_in tester
        current_url.should eq(root_url)
        ability.should be_able_to( :create, FactoryGirl.build(:comment, :user => tester) )
        ability.should be_able_to( :destroy, FactoryGirl.build(:comment, :user => tester) )
        ability.should be_able_to( :read, FactoryGirl.build(:post) )
        ability.should be_able_to( :read, :page )
        ability.should be_able_to( :manage, FactoryGirl.create(:event, :user => tester) )
        ability.should be_able_to( :read, :all )
        visit events_path
        current_url.should eq(events_url)
        page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
        visit new_event_path tester
        current_url.should eq(new_event_url(tester))
        page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      end

      it "should be able to leave comments on events page"

    end

    describe "Admin Users " do
      let(:admin){ FactoryGirl.create(:user, :role => 'admin')}
      let(:ability){ Ability.new(admin) }

      it "should can log in and access the entire site" do
        event = FactoryGirl.create(:event)
        ability.should be_able_to( :manage, :all)
        sign_in admin
        admin.is?(:admin).should be_true
        ability.should be_able_to( :manage, :all)
        visit edit_event_path(:id => event.id, :user_id => admin.id)
        current_url.should eq(edit_event_url(:id => event.id, :user_id => admin.id))
        page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      end

      it "should can view all Events" do
        sign_in admin
        current_url.should eq(root_url)
        visit events_path
        current_url.should eq(events_url)
        page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      end

      it "should be able to see sywadmin without authorization" do
        sign_in admin
        visit sywadmin_dashboard_path
        current_url.should eq(new_admin_user_session_url)
        page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      end
    end

  end

end
