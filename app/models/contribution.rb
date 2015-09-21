class Contribution < ActiveRecord::Base
  acts_as_paranoid
  TRANSACTION_FEE = 2.0
  belongs_to :charity, :inverse_of => :contributions
  belongs_to :guest, :inverse_of => :contribution
  belongs_to :event, :inverse_of => :contributions
  has_one :payment, :inverse_of => :contribution, :validate => true
  has_many :event_transaction_logs, :inverse_of => :contribution
  
  validates :amount, :charity, :guest, :event, :presence => true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
  accepts_nested_attributes_for :payment, :guest
  attr_accessible :payment, :event, :charity, :guest, :guest_attributes, :payment_attributes
  attr_accessible :guest_id, :event_id, :amount, :anonymous, :charity_id, :pay_transaction_fee

  #before_validation :add_transaction_fee, :if => :pay_transaction_fee?
  before_validation :payment_setup

  scope :total_amount_and_guest_count_by_charities, select('*, SUM(contributions.amount) as total_amount, COUNT(contributions.id) as guest_count').joins(:charity).group("charities.id")

  def anonymous?
    self.anonymous
  end
  
  def pay_transaction_fee?
    self.pay_transaction_fee
  end
  
  def add_transaction_fee
    
  end
  
  def payment_setup
    if self.payment && self.amount
      if pay_transaction_fee?
         self.payment.amount = self.amount + TRANSACTION_FEE 
      else
         self.payment.amount = self.amount
      end
      self.payment.processing_response = Payment::PROCESSING_RESPONSES.keys[0] unless self.payment.processing_response
    end
  end

end
