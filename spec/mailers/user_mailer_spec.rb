require "spec_helper"

describe UserMailer do

  it "should send welcome email after create" do
    expect {
      FactoryGirl.create(:user)
    }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

  it "should send release_gift_fund email" do
    event = FactoryGirl.create(:event)
    expect {
      event.set_event_sequence_by_code(:release_gift_fund)
    }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

  it "should send day_of_event email" do
    event = FactoryGirl.create(:event)
    expect {
      event.set_event_sequence_by_code(:day_of_event)
    }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

  it "should send release_donation_fund email" do
    event = FactoryGirl.create(:event)
    expect {
      event.set_event_sequence_by_code(:release_donation_fund)
    }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

  it "should send finish_event email" do
    event = FactoryGirl.create(:event)
    expect {
      event.set_event_sequence_by_code(:finish_event)
    }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

  it "should send release_gift_fund email after create" do
    event = FactoryGirl.create(:event)
    expect {
      event.set_event_sequence_by_code(:send_invitations)
    }.to_not change(ActionMailer::Base.deliveries, :size).by(1)
  end

end