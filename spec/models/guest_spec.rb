require 'spec_helper'

describe Guest do
  subject { FactoryGirl.create(:guest) }
  specify { should belong_to(:event) }
  specify { should belong_to(:user) }
  specify { should belong_to(:lookup_guests_status) }
  specify { should have_one(:contribution) }
  specify { should have_many(:children) }
  specify { should validate_presence_of(:attendance) }
  specify { should be_valid }

  describe "email validation uniqueness" do
    it "should only be enforced within a single Event" do
      guest = FactoryGirl.build(:guest, :email => subject.email, :event => FactoryGirl.create(:event))
      guest.should be_valid
      guest2 = FactoryGirl.build(:guest, :email => subject.email, :event => subject.event)
      guest2.should_not be_valid
    end
  end

  describe "model methods" do
    describe "#lookup_guests_status_id_cant_be_lower_than_is" do
      it "should work" do
        LookupGuestsStatus.count.should eql 6
        id = subject.lookup_guests_status.id
        subject.lookup_guests_status_id += 1
        subject.save
        subject.lookup_guests_status_id.should eql(id)
      end
    end


  end
  
  # describe "Braintree" do
# 
    # it "should work" do
      # subject.create_braintree_customer!
      # subject.has_payment_info?.should be_true
      # subject.get_braintree_customer.should_not be_nil
      # subject.create_test_braintree_credit_card!
      # subject.default_credit_card.should_not be_nil
      # subject.with_braintree_data!.credit_cards.should_not be_nil
      # token = subject.default_credit_card.token
      # subject.delete_braintree_credit_card! token
      # subject.default_credit_card.should be_nil
      # subject.create_test_braintree_credit_card!
      # subject.delete_braintree_all_credit_cards!
      # subject.default_credit_card.should be_nil
      # subject.delete_braintree_customer!
      # subject.get_braintree_customer.should be_nil
    # end
# 
  # end
end

