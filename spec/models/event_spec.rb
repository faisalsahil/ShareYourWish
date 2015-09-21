require 'spec_helper'

describe Event do
  subject { FactoryGirl.create(:event) }
  specify { should belong_to(:user) }
  specify { should have_many(:pictures) }
  specify { should have_many(:guests) }
  specify { should belong_to(:package) }
  specify { should have_one(:cart) }
  specify { should belong_to(:step) }
  specify { should have_many(:event_activity_logs) }
  specify { should have_many(:contributions) }
  specify { should have_many(:children) }
  specify { should have_many(:event_transaction_logs) }
  specify { should belong_to(:lookup_event_sequence) }
  specify { should validate_presence_of(:user) }
  specify { should validate_presence_of(:title) }
  specify { should validate_presence_of(:event_date) }
  specify { should validate_presence_of(:child_full_name) }
  specify { should validate_presence_of(:child_dob) }
  specify { should validate_presence_of(:child_pronoun) }
  specify { should validate_presence_of(:package_id) }
  specify { should validate_presence_of(:theme_code) }
  specify { should be_valid }
  specify { should be_persisted }
  specify { should be_an_instance_of(Event) }

  describe "validation" do

    it "should create slug" do
      subject.slug.should_not be_nil
    end
    
    it "shouldn't be saved without :charity_donation_percent" do
      subject.charity_donation_percent = 12
      subject.should_not be_valid
      subject.charity_donation_percent = nil
      subject.should_not be_valid
    end

    it "shouldn't be saved with :title length not in 2..255" do
      subject.should ensure_length_of(:title).is_at_least(2).is_at_most(255)
    end

    it "shouldn't be saved with :event_date before Time.now" do
      subject.should_not allow_value(Date.today - 1.day).for(:event_date)
    end

    it "shouldn't be saved with :event_date after 1.year" do
      subject.should_not allow_value(Date.today + 2.years).for(:event_date)
    end

    it "shouldn be saved with :start_time '09:10:00'" do
      subject.should allow_value('09:10:00').for(:start_time)
    end

    it "should be saved with :end_time '12:10:00'" do
      subject.should allow_value('12:10:00').for(:end_time)
    end

    it "shouldn't be saved with :child_dob after Time.now" do
      subject.should_not allow_value(Date.today + 1.day).for(:child_dob)
    end

    it "shouldn't be saved with :child_dob before 18.years" do
      subject.should_not allow_value(Date.today + 19.years).for(:child_dob)
    end

    it "should be saved without :parental_consent_status" do
      subject.parental_consent_status = nil
      assert subject.save!
    end

    it "shouldn't be saved with :parental_consent_status not in [:notConfirmed, :confirmed]" do
      subject.should_not allow_value('fail').for(:parental_consent_status)
    end

    it "shouldn't be saved with :magic_phrase length not in 2..255" do
      subject.should ensure_length_of(:magic_phrase).is_at_least(2).is_at_most(255)
    end

    it "shouldn't be saved with :status not in [:in_progress, :published, :cancelled]" do
      subject.should_not allow_value('fail').for(:status)
    end
    
    it "shouldn't allow :rsvp_by less than Event.event_date" do
      subject.should allow_value(Date.today).for(:rsvp_by)
      subject.should_not allow_value(subject.event_date).for(:rsvp_by)
    end
    
    it "should validate_presence_of :rsvp_by on update" do
      subject.rsvp_by = nil
      subject.should_not be_valid
    end
    
    it "should validates_length_of :charities, :in => 1..3 on update" do
      subject.should be_valid
      subject.stubs(:last_step?).returns(true)
      subject.charities = FactoryGirl.create_list(:charity, 5)
      subject.should_not be_valid
    end

  end

  describe "Search" do

    it "should work" do
      keyword = 'find me'
      FactoryGirl.create(:event)
      FactoryGirl.create(:event)
      FactoryGirl.create(:event, :title => keyword)
      FactoryGirl.create(:event, :location_name => keyword)
      FactoryGirl.create(:event, :child_full_name => keyword)
      Event.count.should eql 5
      search_results = Event.search keyword
      search_results.total_entries.should eql 3
    end

  end

  describe "Funds" do
    describe "Fund dates" do
      it 'donation fund date should be greater then gift fund date' do
      (Event::DONATION_FUND_UNLOCK_DAYS > Event::GIFT_FUND_UNLOCK_DAYS).should be_true
        (subject.donation_fund_days_to_unlock > subject.gift_fund_days_to_unlock).should be_true
      end
    end

    describe "Gift fund" do
      it "should work correct" do
        subject.gift_fund_locked?.should be_true
        subject.gift_fund_unlock!
        subject.gift_fund_locked?.should be_false
        subject.gift_fund_lock!
        subject.gift_fund_locked?.should be_true
      end
    end

    describe "Donation fund" do
      it "should work correct" do
        subject.donation_fund_locked?.should be_true
        subject.donation_fund_unlock!
        subject.donation_fund_locked?.should be_false
        subject.donation_fund_lock!
        subject.donation_fund_locked?.should be_true
      end
    end

    describe "Fund lock flow" do
      it 'should unlock gift_fund only' do
        sequence = LookupEventSequence.find_by_code :release_gift_fund  
        subject.gift_fund_locked?.should be_true
        subject.donation_fund_locked?.should be_true
        subject.update_attribute(:event_date, Date.today - Event::GIFT_FUND_UNLOCK_DAYS.days)
        subject.funds_unlock!
        subject.gift_fund_locked?.should be_false
        subject.event_sequence.should eql(sequence.sequence)
        subject.donation_fund_locked?.should be_true
      end

      it 'should lock gift_fund and donation_fund' do
        sequence = LookupEventSequence.find_by_code :release_donation_fund
        subject.gift_fund_locked?.should be_true
        subject.donation_fund_locked?.should be_true
        subject.donation_fund_unlock!
        subject.event_sequence.should eql sequence.sequence
        subject.gift_fund_unlock!
        subject.gift_fund_locked?.should be_false
        subject.donation_fund_locked?.should be_false
        subject.funds_lock!
        subject.gift_fund_locked?.should be_true
        subject.donation_fund_locked?.should be_true
      end
    end

  end

  describe "Contributions" do
    describe "lock flow" do
      it 'lock contributions' do 
        subject.contributions_locked?.should be_false
        subject.update_attribute(:event_date, DateTime.now + 1.days)
        subject.contributions_lock!
        subject.contributions_locked?.should be_false
        subject.update_attribute(:event_date, DateTime.now)
        subject.contributions_lock!
        subject.contributions_locked?.should be_true
      end
    end
  end
end
