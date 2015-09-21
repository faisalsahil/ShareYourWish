class EventTransactionLog < ActiveRecord::Base

  belongs_to :contribution, :inverse_of => :event_transaction_logs
  belongs_to :event, :inverse_of => :event_transaction_logs
  belongs_to :payment, :inverse_of => :event_transaction_logs
  belongs_to :charity, :inverse_of => :event_transaction_logs
  
  validates :event_transaction_log_category_id, :description, :event, :presence => true
  validates :event_fund, :gift_fund, :donation_fund, :syw_fund, :numericality => true
  validates_inclusion_of :event_transaction_log_category_id, :in => EventTransactionLogCategory::IDS
  validates_presence_of :payment, :if => :demand_payment_presence?
  validates_presence_of :charity, :if => :demand_charity_presence?
  validates_presence_of :contribution, :if => :demand_contribution_presence?
  
  scope :open_balances, where(:event_transaction_log_category_id => 101)
  scope :contribution_from_guests, where(:event_transaction_log_category_id => 102)
  scope :deduct_cc_fee, where(:event_transaction_log_category_id => 103)
  scope :deduct_syw_fe, where(:event_transaction_log_category_id => 104)
  scope :gift_fund_allocates, where(:event_transaction_log_category_id => 105)
  scope :donation_fund_allocates, where(:event_transaction_log_category_id => 106)
  scope :purchases, where(:event_transaction_log_category_id => 107)
  scope :gift_fund_disbursements, where(:event_transaction_log_category_id => 108)
  scope :donation_fund_disbursements, where(:event_transaction_log_category_id => 109)
  scope :syw_fund_disbursements, where(:event_transaction_log_category_id => 110)
  
  scope :total_amount_and_guest_count_by_charities, select('*, SUM(event_transaction_logs.donation_fund) as total_amount, COUNT(event_transaction_logs.id) as guest_count').joins(:charity).group("event_transaction_logs.charity_id")

  def demand_payment_presence?
    [102,107].include? self.event_transaction_log_category_id
  end
  
  def demand_charity_presence?
    [106,109].include? self.event_transaction_log_category_id
  end
  
  def demand_contribution_presence?
    [102,103,104,105,106].include? self.event_transaction_log_category_id
  end
  
  # after event created callback
  def self.open_balance event
    return false unless event.is_a? Event
    self.create!(:event => event, 
                 :event_transaction_log_category_id => 101, 
                 :description => EventTransactionLogCategory::MESSAGES[101])
  end
  
  # after contribution payment created callback
  def self.contribution_from_guest payment
    return false unless payment.is_a? Payment
    return false unless payment.contribution.present?
    return false unless payment.contribution.guest.present?
    return false unless payment.contribution.event.present?
    self.create!(:event => payment.contribution.event,
                 :payment => payment,
                 :contribution => payment.contribution,
                 :event_fund => payment.amount,
                 :event_transaction_log_category_id => 102,
                 :description => sprintf(EventTransactionLogCategory::MESSAGES[102], 
                                        payment.contribution.id, 
                                        payment.contribution.guest.full_name,
                                        payment.contribution.guest.id)
                )
    self.deduct_cc_fee_from_contribution payment
    self.deduct_syw_fee_from_contribution payment
    self.gift_fund_allocate_from_contribution payment
    self.donation_fund_allocate_from_contribution payment
  end
  
  def self.deduct_cc_fee_from_contribution payment
    return false unless payment.is_a? Payment
    return false unless payment.contribution.present?
    self.create!(:event => payment.contribution.event,
                 :contribution => payment.contribution,
                 :event_fund => (payment.contribution.amount*Event::CC_FEE_PERCENT + Event::CC_FEE_FIXED) *-1,
                 :syw_fund => payment.contribution.amount*Event::CC_FEE_PERCENT + Event::CC_FEE_FIXED ,
                 :event_transaction_log_category_id => 103,
                 :description => sprintf(EventTransactionLogCategory::MESSAGES[103], payment.contribution.id)
                )
  end
  
  def self.deduct_syw_fee_from_contribution payment
    return false unless payment.is_a? Payment
    return false unless payment.contribution.present?
    self.create!(:event => payment.contribution.event,
                 :contribution => payment.contribution,
                 :event_fund => -Event::SYW_FEE,
                 :syw_fund => Event::SYW_FEE,
                 :event_transaction_log_category_id => 104,
                 :description => sprintf(EventTransactionLogCategory::MESSAGES[104], payment.contribution.id)
                )
  end
  
  def self.gift_fund_allocate_from_contribution payment
    return false unless payment.is_a? Payment
    return false unless payment.contribution.present?
    return false unless payment.contribution.event.present?
    return false unless payment.contribution.event.charity_donation_percent.present?
    fees = payment.contribution.amount*Event::CC_FEE_PERCENT + Event::CC_FEE_FIXED + Event::SYW_FEE
    gift_fund = (payment.amount-fees) * (1-payment.contribution.event.charity_donation_percent)
    self.create!(:event => payment.contribution.event,
                 :contribution => payment.contribution,
                 :event_fund => gift_fund*-1,
                 :gift_fund => gift_fund,
                 :event_transaction_log_category_id => 105,
                 :description => sprintf(EventTransactionLogCategory::MESSAGES[105], payment.contribution.id)
                )
  end
  
  def self.donation_fund_allocate_from_contribution payment
    return false unless payment.is_a? Payment
    return false unless payment.contribution.present?
    return false unless payment.contribution.event.present?
    return false unless payment.contribution.charity.present?
    return false unless payment.contribution.event.charity_donation_percent.present?
    fees = payment.contribution.amount*Event::CC_FEE_PERCENT + Event::CC_FEE_FIXED + Event::SYW_FEE
    donation_fund =  (payment.amount-fees) * payment.contribution.event.charity_donation_percent
    self.create!(:event => payment.contribution.event,
                 :event_fund => donation_fund*-1,
                 :donation_fund => donation_fund,
                 :charity => payment.contribution.charity,
                 :contribution => payment.contribution,
                 :event_transaction_log_category_id => 106,
                 :description => sprintf(EventTransactionLogCategory::MESSAGES[106], payment.contribution.id),
                 :memo => sprintf("%s (%s)", payment.contribution.charity.name, payment.contribution.charity.syw_altkey)
                )
  end
  
  # after order payment created callback
  def self.purchase payment
    return false unless payment.is_a? Payment
    return false unless payment.order.present?
    return false unless payment.order.event.present?
    self.create!(:event => payment.order.event,
                 :payment => payment,
                 :syw_fund => payment.amount,
                 :event_transaction_log_category_id => 107,
                 :description => EventTransactionLogCategory::MESSAGES[107],
                 :memo => 'Upgrade Package'
                )
  end
  
  # after visit release_gift_fund_event_path
  def self.gift_fund_disbursement event
    return false unless event.is_a? Event
    self.create!(:event => event,
                 :gift_fund => event.gift_fund*-1,
                 :event_transaction_log_category_id => 108, 
                 :description => EventTransactionLogCategory::MESSAGES[108])
  end
  
  # after visit release_donation_fund_event_path
  def self.donation_fund_disbursement event
    return false unless event.is_a? Event
    event.charities.contributed.each do |charity|
      self.donation_fund_disbursement_charity event, charity
    end
    event.set_event_sequence_by_code(:event_complete)
  end
  
  def self.donation_fund_disbursement_charity event, charity
    return false unless event.is_a? Event
    return false unless charity.is_a? Charity
    self.create!(:event => event,
                 :charity => charity,
                 :donation_fund => event.donation_fund*-1,
                 :event_transaction_log_category_id => 109, 
                 :description => EventTransactionLogCategory::MESSAGES[109],
                 :memo => sprintf("%s (%s)", charity.name, charity.syw_altkey))
  end
  
  def self.syw_fund_disbursement event
    return false unless event.is_a? Event
    self.create!(:event => event,
                 :syw_fund => event.syw_fund*-1,
                 :event_transaction_log_category_id => 110, 
                 :description => EventTransactionLogCategory::MESSAGES[110])
  end
  
end
