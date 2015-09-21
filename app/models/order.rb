class Order < ActiveRecord::Base
  acts_as_paranoid
  has_many :line_items, dependent: :destroy
  belongs_to :event, :inverse_of => :order
  belongs_to :user
  belongs_to :billing_address, :class_name => 'Address', :conditions => {:atype => :billing}, :validate => true
  belongs_to :shipping_address, :class_name => 'Address', :conditions => {:atype => :shipping}, :validate => true
  has_one :payment, :inverse_of => :order, :validate => true
  has_many :shipments
  accepts_nested_attributes_for :payment, :billing_address, :shipping_address
  attr_accessor :subtotal
  after_save :publish_event, :if => :event?
  
  def publish_event
    return false unless self.event
    self.event.publish!
  end
  
  def subtotal
    line_items.to_a.sum { |li| li.ext_cost }
 	end

  def calc_total_cost
    subtotal + tax_total_cost + shipping_total_cost + adjustments_total_cost
  end
  
  def paid?
    self.payment.present? && self.payment.persisted?
  end
  
  def event?
    self.event.present?
  end
  
  def transmit_line_items_from_cart cart
    return false unless cart.is_a? Cart
    return false unless cart.line_items.present?
    self.line_items << cart.line_items
  end  
end