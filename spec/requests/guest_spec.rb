require 'spec_helper'

describe "Guest" do
  describe "create with magic phrase flow" do
    it "create guest" do
      keyword = 'find me'
      FactoryGirl.create(:guest, :id => Guest::ANONYMOUS_ID)
      guest = FactoryGirl.build(:guest)
      FactoryGirl.create(:event)
      FactoryGirl.create(:event)
      event = FactoryGirl.create(:event, :title => keyword)
      FactoryGirl.create(:event, :location_name => keyword)
      FactoryGirl.create(:event, :child_full_name => keyword)
      # find event by search
      visit search_path(:q => keyword)
      current_path.should eq(search_path)
      page.should have_selector("div.event-item-title:contains('#{keyword}')")
      # show visitor_entrance form
      visit event_path event
      current_path.should eq(visitor_entrance_event_path(event))
      page.should have_selector("form#visitor_entrance")
      # wrong magic_phrase
      fill_in "magic_phrase", with: 'fail'
      fill_in "guest_full_name", with: guest.full_name
      fill_in "guest_email", with: guest.email
      click_button('guest_submit_button')
      current_path.should eq(visitor_entrance_event_path(event))
      page.should have_selector("div.flash.error")
      # correct magic_phrase creates new guest
      fill_in "magic_phrase", with: event.magic_phrase
      click_button('guest_submit_button')
      guest = Guest.last
      # log activity
      EventActivityLog.count.should eql 2
      current_path.should eq(event_guest_show_path(event.slug, guest, guest.guest_access_token))
    end
  end

  describe "RSVP" do
    context "flow", :js => true do

      before(:each) do
        FactoryGirl.create(:guest, :id => Guest::ANONYMOUS_ID)
        @event = FactoryGirl.create(:event, :title => 'Yahoo')
        @guest = FactoryGirl.create(:guest, :event => @event)
        @guest_path = event_guest_show_path(@event.slug, @guest, @guest.guest_access_token)
        @message = 'message'
      end

      it "change guest RSVP" do
        pending
        visit @guest_path
        save_and_open_page
        current_path.should eq(@guest_path)
        Event.find_by_slug(@event.slug).should_not be_nil
        page.should have_selector("form.edit_guest")
        fill_in "guest_message", with: @message
        choose("message_type_board")
        page.execute_script("jQuery('#guest_attendance_yes').click()")
        
        @guest.reload
        @guest.message.should eql(@message)
      end

      it "don't post blank messages, "
      it "clear the field after the message is posted"
    end
  end
end
