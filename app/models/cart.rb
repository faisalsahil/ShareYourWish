class Cart < ActiveRecord::Base
  belongs_to :event, :inverse_of => :cart
  belongs_to :user
  has_many :line_items, dependent: :destroy
  
  def subtotal
 	  line_items.to_a.sum { |li| li.ext_cost }
 	end
 	
 	def positive?
 	  subtotal > 0
 	end
 	
 	def add_package_bundle_items package_proxy_item
      self.line_items.each do |li|
         li.destroy
      end
      pkg = Package.find_by_proxy_item_id(package_proxy_item.id)
      pkg.items.each do |pi|
         self.line_items.build(item: pi, :cost=>0)
      end if pkg.is_a? Package
      self.save
      self.event.update_attribute(:package_id, pkg.id) if self.event && pkg
   end
 	
end
