require 'spec_helper'

describe User do
  subject { FactoryGirl.create(:user) }
  specify { should have_many(:events) }
  specify { should have_many(:pictures) }
  specify { should have_many(:guests) }
  specify { should have_many(:comments) }
  specify { should have_many(:orders) }
  specify { should have_many(:carts) }
  specify { should have_many(:addresses) }
  specify { should have_many(:authentications) }
  specify { should have_many(:feedbacks) }
  specify { should validate_uniqueness_of(:email) }
  specify { should validate_presence_of(:role) }
  specify { should be_valid}

  describe "validate" do
    it "shoul validate_presence_of :email on create" do
      user = FactoryGirl.build(:user)
      user.should validate_presence_of(:email)
    end
  end

  describe "Braintree" do

    it "should work" do
      subject.create_braintree_customer!
      subject.has_payment_info?.should be_true
      subject.get_braintree_customer.should_not be_nil
      subject.create_test_braintree_credit_card!
      subject.default_credit_card.should_not be_nil
      subject.with_braintree_data!.credit_cards.should_not be_nil
      token = subject.default_credit_card.token
      subject.delete_braintree_credit_card! token
      subject.default_credit_card.should be_nil
      subject.create_test_braintree_credit_card!
      subject.delete_braintree_all_credit_cards!
      subject.default_credit_card.should be_nil
      subject.delete_braintree_customer!
      subject.get_braintree_customer.should be_nil
    end

  end
end
