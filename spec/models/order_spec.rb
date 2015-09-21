require 'spec_helper'

describe Order do
  subject { FactoryGirl.create(:order) }
  specify { should have_many(:line_items) }
  specify { should belong_to(:user) }
  specify { should belong_to(:event) }
  specify { should belong_to(:billing_address) }
  specify { should belong_to(:shipping_address) }
  specify { should have_one(:payment) }
  specify { should have_many(:shipments) }
  specify { should accept_nested_attributes_for(:payment) }
  specify { should accept_nested_attributes_for(:billing_address) }
  specify { should accept_nested_attributes_for(:shipping_address) }
  specify { should be_valid }

  describe "create" do
    it "should create payment and publish event" do
      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event, :user => user)
      charity = FactoryGirl.create(:charity)
      event.charities<<charity
      event.save
      subject.user = user
      subject.event = event
      cart = FactoryGirl.create(:cart)
      10.times do
        cart.line_items << FactoryGirl.create(:line_item)
      end
      cart.line_items.count.should eql 10
      subject.transmit_line_items_from_cart cart
      payment = FactoryGirl.build(:payment, :order => subject)
      expect {
        subject.save!
      }.to change(Payment, :count).by(1)
      user.get_braintree_customer.should_not be_nil
      user.default_credit_card.should_not be_nil
      subject.event.published?.should be_true
      user.delete_braintree_customer!.should be_true
    end
  end

end
