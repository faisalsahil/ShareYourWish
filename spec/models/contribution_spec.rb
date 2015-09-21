require 'spec_helper'

describe Contribution do
  subject { FactoryGirl.create(:contribution) }
  specify { should belong_to(:charity) }
  specify { should belong_to(:guest) }
  specify { should belong_to(:event) }
  specify { should have_one(:payment) }
  specify { should have_many(:event_transaction_logs) }
  specify { should validate_presence_of(:amount) }
  specify { should validate_presence_of(:charity) }
  specify { should validate_presence_of(:guest) }
  specify { should validate_presence_of(:event) }
  specify { should validate_numericality_of(:amount) }
  specify { should accept_nested_attributes_for(:guest) }
  specify { should be_valid }

  describe "create" do
    it "should create payment" do
      event = FactoryGirl.create(:event)
      charity = FactoryGirl.create(:charity)
      event.charities<<charity
      event.save
      guest = FactoryGirl.create(:guest, :event => event)
      subject.guest = guest
      payment = FactoryGirl.build(:payment, :contribution => subject)
      expect {
        subject.save
      }.to change(Payment, :count).by(1)
      guest.contributed?.should be_true
      guest.get_braintree_customer.should_not be_nil
      guest.default_credit_card.should_not be_nil
    end
  end

end
