require 'spec_helper'

describe Payment do
  subject { FactoryGirl.create(:payment) }
  specify { should belong_to(:order) }
  specify { should belong_to(:contribution) }
  specify { should have_many(:event_transaction_logs) }
  specify { should validate_presence_of(:amount) }
  specify { should validate_presence_of(:cc_num) }
  specify { should validate_presence_of(:cc_exp_month) }
  specify { should validate_presence_of(:cc_exp_year) }
  specify { should validate_presence_of(:cc_cvv) }
  specify { should validate_presence_of(:cc_postal_code) }
  specify { should validate_numericality_of(:amount) }
  specify { should be_valid }
  
  describe "validation" do
    it "should validates_inclusion_of processing_response in PROCESSING_RESPONSES" do
      subject.should_not allow_value('fail').for(:processing_response)
      subject.should allow_value(Payment::PROCESSING_RESPONSES.keys[0]).for(:processing_response)
    end
    
    it "should validates_format_of :cc_cvv, :with => /^[0-9]+$/" do
      subject.should_not allow_value('hjhUggfrt123').for(:cc_cvv)
      subject.should allow_value('0123').for(:cc_cvv)
    end  
    
    it "should work with or without a leading 0" do
      subject.cc_cvv = '0123'
      subject.should be_valid
      subject.save
      subject.reload
      subject.cc_cvv.should eql '0123'
      subject.cc_cvv = '1234'
      subject.should be_valid
      subject.save
      subject.reload
      subject.cc_cvv.should eql '1234'
    end

    it "should ensure that credit card expiration date is later than today + 1 month" do
      date = Date.today + 2.weeks
      subject.cc_exp_month = date.month.to_s
      subject.cc_exp_year = date.year.to_s
      subject.should_not be_valid
      date = Date.today + 2.months
      subject.cc_exp_month = date.month.to_s
      subject.cc_exp_year = date.year.to_s
      subject.should be_valid
    end
  end

  describe "method" do

    describe "#clear_cc_num" do
      it "should clear cc_num from non numbers" do
        subject.cc_num = "K123LJn  lkkk--ss,./LKJkl  bvsa3 \n 34577"
        subject.valid?
        subject.cc_num.should eql('123334577')
      end
    end

    describe "#inclusion_of_cc_type_in_default_credit_card_types" do
      it "should not be valid with cc_type Diner's Club" do
        subject.cc_num = '30569309025904'
        subject.should_not be_valid
      end
      it "should not be valid with cc_type JCB" do
        subject.cc_num = '3530111333300000'
        subject.should_not be_valid
      end
    end

    describe "#set_card_type_from_number" do
      it "should set card type from card number" do
        subject.cc_type.should eql(:visa)
        subject.update_attributes({:cc_num => '4012888888881881'})
        subject.cc_type.should eql(:visa)
        subject.update_attributes(:cc_num => '5555555555554444')
        subject.cc_type.should eql(:master_card)
        subject.update_attributes(:cc_num => '5105105105105100')
        subject.cc_type.should eql(:master_card)
        subject.update_attributes(:cc_num => '378282246310005')
        subject.cc_type.should eql(:amex)
        subject.update_attributes(:cc_num => '371449635398431')
        subject.cc_type.should eql(:amex)
        subject.update_attributes(:cc_num => '6011111111111117')
        subject.cc_type.should eql(:discover)
        subject.update_attributes(:cc_num => '6011000990139424')
        subject.cc_type.should eql(:discover)
      end
    end

  end
end
