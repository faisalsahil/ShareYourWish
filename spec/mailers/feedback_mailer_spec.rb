require "spec_helper"

describe FeedbackMailer do
  subject { FactoryGirl.build(:feedback) }

  it "should deliver contact_us email" do          
      expect {
        subject.send!
      }.to change(ActionMailer::Base.deliveries, :size).by(1)  
  end  

  it "should send email after create" do          
      expect {
        FactoryGirl.create(:feedback) 
      }.to change(ActionMailer::Base.deliveries, :size).by(1)   
  end 
end
