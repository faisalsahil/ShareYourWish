class Item < ActiveRecord::Base
  acts_as_paranoid
  has_one :picture, :as => :imageable
  has_and_belongs_to_many :packages
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  default_scope :order => "sort_order asc"
  scope :no_package_proxies, where(:is_package_proxy => false, :is_visible => true)
  attr_accessible :id, :name, :description, :cost, :taxable, :is_visible, :is_package_proxy
  attr_accessible :sort_order, :package_ids, :picture
  
  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
     if line_items.empty?
        return true
     else
        errors.add(:base, 'Cannot Delete Item; Delete Line Items First')
        return false
     end
  end
  
  
end
