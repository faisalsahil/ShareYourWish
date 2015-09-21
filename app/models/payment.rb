class Payment < ActiveRecord::Base
  acts_as_paranoid
  CARD_DATA = {
    :visa => { :lengths => [13,16], :prefixes => [4] },
    :master_card => { :lengths => [16], :prefixes => [51,52,53,54,55] },
    :DinersClub => { :lengths => [14,16], :prefixes => [305,36,38,54,55] },
    :CarteBlanche => { :lengths => [14], :prefixes => [300,301,302,303,304,305] },
    :amex => { :lengths => [15], :prefixes => [34,37] },
    :discover => { :lengths => [16], :prefixes => [6011,622,64,65] },
    :JCB => { :lengths => [16], :prefixes => [35] },
    :enRoute => { :lengths => [15], :prefixes => [2014,2149] },
    :Solo => { :lengths => [16,18,19], :prefixes => [6334, 6767] },
    :Switch => { :lengths => [16,18,19], :prefixes => [4903,4905,4911,4936,564182,633110,6333,6759] },
    :Maestro => { :lengths => [12,13,14,15,16,18,19], :prefixes => [5018,5020,5038,6304,6759,6761] },
    :VisaElectron => { :lengths => [16], :prefixes => [417500,4917,4913,4508,4844] },
    :LaserCard => { :lengths => [16,17,18,19], :prefixes => [6304,6706,6771,6709] },
  }
  PROCESSING_RESPONSES = {'awaiting processing' => 'Awaiting Processing', 'complete-OK' => 'Complete OK', 'error' => 'Error', 'cancelled' => 'Cancelled'}
  DEFAULT_CREDIT_CARD_TYPES = {:amex => 'American Express', :master_card => 'Master Card', :visa => 'Visa', :discover => 'Discover'}
  PAYMENT_METHODS = [:braintree]
  CC_EXP_MONTHS = (1..12).to_a.map{|e|e.to_s}
  CC_EXP_YEARS = (Date.today.year..Date.today.year+8).to_a.map{|e|e.to_s}
  belongs_to :order, :inverse_of => :payment
  belongs_to :contribution, :inverse_of => :payment
  has_many :event_transaction_logs, :inverse_of => :payment
  validates :amount, :presence => true
  validates_numericality_of :amount, :greater_than => 0
  
  attr_accessor :cc_num, :cc_type, :cc_exp_month, :cc_exp_year, :cc_cvv, :cc_postal_code
  attr_accessible :order_id, :amount, :payment_method, :last_four_digits, :status, :processing_response, :contribution_id
  attr_accessible :order, :contribution, :cc_num, :cc_type, :cc_exp_month, :cc_exp_year, :cc_cvv, :cc_postal_code
  
  validates :cc_num, :cc_exp_month, :cc_exp_year, :cc_cvv, :cc_postal_code, :presence => true
  validates_inclusion_of :processing_response, :in => PROCESSING_RESPONSES.keys
  validates :cc_num, :credit_card_number => true
  validates_format_of :cc_cvv, :with => /^[0-9]+$/
  validates_length_of :cc_cvv, :in => 3..4
  validates_inclusion_of :cc_exp_month, :in => CC_EXP_MONTHS
  validates_inclusion_of :cc_exp_year, :in => CC_EXP_YEARS
  validates_as_postal_code :cc_postal_code, :country => "USA"
  before_validation :clear_cc_num, :set_card_type_from_number
  before_create :set_last_four_digits
  before_create :create_contribution_transaction, :if => :contribution?
  before_create :create_order_transaction, :if => :order?
  validate :inclusion_of_cc_type_in_default_credit_card_types, :if => :cc_num
  
  after_create :contribution_from_guest_log, :if => :contribution?
  after_create :purchase_log, :if => :order?
  
  def contribution_from_guest_log
    EventTransactionLog::contribution_from_guest(self)
  end
  
  def purchase_log
    EventTransactionLog::purchase(self)
  end
  
  def inclusion_of_cc_type_in_default_credit_card_types
    return false unless self.cc_num && self.cc_type
    errors.add(:cc_num, "Unsupported credit card type.") unless DEFAULT_CREDIT_CARD_TYPES.include?(self.cc_type)
  end  

  def clear_cc_num 
    self.cc_num = self.cc_num.to_s.gsub(/\D/, '') unless self.cc_num.nil?
  end

  def set_card_type_from_number
    self.cc_type = self::card_type_from_number self.cc_num
  end
  
  def set_last_four_digits
    self.last_four_digits = self.cc_num.to_s[-4,4] if self.cc_num
  end

  def card_type_from_number card_number
    CARD_DATA.each do |card, data|
      data[:prefixes].each do |prefix|
        return card if card_number.to_s.starts_with?(prefix.to_s)
      end
    end
  end
  
  def credit_card_hash
   {:number => self.cc_num,
    :expiration_month => self.cc_exp_month,
    :expiration_year => self.cc_exp_year,
    :cvv => self.cc_cvv}
  end
  
  def create_contribution_transaction
    case self.payment_method.to_sym
    when PAYMENT_METHODS[0]
      return false unless self.contribution
      return false unless self.contribution.guest
      self.contribution.guest.braintree_transaction_create! self
    end
  end  
  
  def create_order_transaction
    case self.payment_method.to_sym
    when PAYMENT_METHODS[0]
      return false unless self.order
      return false unless self.order.user && self.order.event
      self.order.user.braintree_transaction_create! self
    end
  end
  
  def contribution?
    self.contribution.present?
  end
  
  def order?
    self.order.present?
  end

end
