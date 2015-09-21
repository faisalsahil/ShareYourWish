require 'spec_helper'
# save_and_open_page

describe "Contribution" do
  subject { FactoryGirl.build(:contribution) }

  describe "Leave contribution as guest on invite guest page" do
    
    it "should work" do 
      event = FactoryGirl.create(:event)
      event.charities.clear
      charity = FactoryGirl.create(:charity)
      payment = FactoryGirl.build(:payment, :contribution => subject)
      event.charities<<charity
      event.save
      event.charities.count.should eq(1)
      guest = FactoryGirl.create(:guest, :event => event)
      url = event_guest_show_path(event.slug, guest.id, guest.guest_access_token)
      visit url
      current_path.should eq(url)
      page.should_not have_selector('div.flash.alert:contains("You are not authorized to access this page.")')
      page.should have_selector("div#event-page-welcome:contains('Welcome #{guest.full_name}')")
      fill_in "contribution_amount", with: subject.amount
      fill_in "contribution_payment_attributes_cc_num", with: payment.cc_num
      fill_in "contribution_payment_attributes_cc_cvv", with: payment.cc_cvv.to_s
      fill_in "contribution_payment_attributes_cc_postal_code", with: payment.cc_postal_code
      select '1', :from => 'contribution_payment_attributes_cc_exp_month'
      select((Date.today.year+1).to_s, :from => "contribution_payment_attributes_cc_exp_year")
      choose("contribution_charity_id_#{charity.id}")
      click_button "send_guest_contribution"
      current_path.should eq(url)
      page.should have_selector('div.flash.notice:contains("Thanks! Your contribution has been accepted.")')
    end
  end
  
  describe "When Guest clicks 'No Thanks'" do

    before(:each) do
      @event = FactoryGirl.create(:event)
      @guest = FactoryGirl.create(:guest, :event => @event)
      url = event_guest_show_path(@event.slug, @guest.id, @guest.guest_access_token)
      visit url
      current_path.should eq(url)
      click_link('No, Thanks')
    end

    it "should update the Guest status"
    it "should post to the Event Activity log" 
    it "should show a response to the Guest that their response was acknowledged"
  end

end
