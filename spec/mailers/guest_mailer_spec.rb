require "spec_helper"

describe GuestMailer do
  subject { FactoryGirl.create(:guest) }

  it "should deliver invite email" do
      expect {
        subject.invite!
      }.to change(ActionMailer::Base.deliveries, :size).by(3)
  end

  it "should deliver remind email" do
      expect {
        subject.remind!
      }.to change(ActionMailer::Base.deliveries, :size).by(3)
  end
  
  it "should deliver thank email" do
      expect {
        subject.thank!
      }.to change(ActionMailer::Base.deliveries, :size).by(3)
  end
  
  it "should deliver custom email" do
      expect {
        subject.send_custom_message!('subject', 'title', 'body')
      }.to change(ActionMailer::Base.deliveries, :size).by(3)
      
      expect {
        GuestMailer.custom(subject, 'subject', 'title', 'body').deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
  end

end
