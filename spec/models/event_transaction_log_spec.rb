require 'spec_helper'

describe EventTransactionLog do
  subject { FactoryGirl.create(:event_transaction_log) }
  specify { should belong_to(:contribution) }
  specify { should belong_to(:event) }
  specify { should belong_to(:payment) }
  specify { should belong_to(:charity) }
  specify { should validate_presence_of(:event_transaction_log_category_id) }
  specify { should validate_presence_of(:description) }
  specify { should validate_presence_of(:event) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(EventTransactionLog) }
  
  describe "Event Log flow" do
    
    let :contribution do
      FactoryGirl.create(:contribution)
    end
    
    let :event do
      FactoryGirl.create(:event)
    end
    
    let :order do
      FactoryGirl.create(:order, :event => event)
    end

    it "create log open_balance after event creation" do
      expect {
        FactoryGirl.create(:event)
      }.to change(EventTransactionLog.open_balances, :count).by(1)
    end
    
    it "create log contribution_from_guest after contribution payment creation" do
      expect {
          payment = FactoryGirl.build(:payment, :contribution => contribution)
          payment.stubs(:create_contribution_transaction).returns(true)
          payment.save
      }.to change(EventTransactionLog.contribution_from_guests, :count).by(1)
      EventTransactionLog.deduct_cc_fee.count.should eql 1
      EventTransactionLog.deduct_syw_fe.count.should eql 1
      EventTransactionLog.gift_fund_allocates.count.should eql 1
      EventTransactionLog.donation_fund_allocates.count.should eql 1
    end
    
    it "create log purchase after order payment creation" do
      expect {
        payment = FactoryGirl.build(:payment, :order => order)
        payment.stubs(:create_order_transaction).returns(true)
        payment.save
      }.to change(EventTransactionLog.purchases, :count).by(1)
    end
    
    it "create log syw_fund_disbursement" do
      expect {
        EventTransactionLog.syw_fund_disbursement event
      }.to change(EventTransactionLog.syw_fund_disbursements, :count).by(1)
    end
    
  end
  
  describe "Event Report" do
    it "works right" do
      # create event 
      event = FactoryGirl.create(:event, :charities => FactoryGirl.create_list(:charity, 2))
      event.should be_persisted
      event.event_transaction_logs.open_balances.should be_present
      # add some guests
      guests = FactoryGirl.create_list(:guest, 4, :event => event)
      event.guests.count.should eql 4
      # lets invite guests
      expect {
        guests.each{|guest| guest.invite!}
      }.to change(ActionMailer::Base.deliveries, :size).by(4)
      
      # lets select package and pay for it
      package = FactoryGirl.create(:package)
      package.should be_persisted
      event.package = package
      event.save
      event.package.should eql package
      # create cart and add some items
      cart = FactoryGirl.create(:cart, :event => event)
      cart.should be_persisted
      # add some items to cart 
      FactoryGirl.create_list(:line_item, 2, :cart => cart)
      cart.line_items.present?.should be_true
      order = FactoryGirl.build(:order, :event => event)
      order.transmit_line_items_from_cart cart
      order.line_items.present?.should be_true
      # let's create payment
      expect {
        payment = FactoryGirl.build(:payment, :order => order)
        payment.stubs(:create_order_transaction).returns(true)
        payment.save
      }.to change(EventTransactionLog.purchases, :count).by(1)
      event.should be_published
      # let's create some guest contributions
      guests.each do |guest|
        payment = FactoryGirl.build(:payment, :amount => 12.00)
        payment.stubs(:create_contribution_transaction).returns(true)
        contribution = FactoryGirl.create(:contribution,
                           :event => event,
                           :guest => guest,
                           :amount => 12.00,
                           :charity => event.charities.first,
                           :payment => payment)
        contribution.should be_persisted
        contribution.charity.should be_persisted
        contribution.payment.should be_persisted
        guest.should be_contributed
      end
      event.contributions.count.should eql 4
      event.event_transaction_logs.contribution_from_guests.count.should eql(4)
      event.charities.contributed.should be_present
      
      # check calculations
      event.contributions_total_amount.to_f.should eql 48.0
      event.contributions_total_amount_after_fees.should eql 38.13
      event.event_fund.should eql 0.0
      event.gift_fund.should eql 9.53
      event.donation_fund.should eql 28.6
      event.syw_fund.should eql 9.87
      
      # lets make gift_fund_disbursement
      EventTransactionLog.gift_fund_disbursement event
      event.event_transaction_logs.gift_fund_disbursements.should be_present
      
      # lets make donation_fund_disbursement
      EventTransactionLog.donation_fund_disbursement event
      event.event_transaction_logs.donation_fund_disbursements.should be_present
      
      # lets make syw_fund_disbursement
      EventTransactionLog.syw_fund_disbursement event
      event.event_transaction_logs.syw_fund_disbursements.should be_present
      
    end
  end

end

