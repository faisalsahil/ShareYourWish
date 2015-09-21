class LineItem < ActiveRecord::Base
   acts_as_paranoid
   belongs_to :item
   belongs_to :cart
   belongs_to :order
   
   validates :quantity, :inclusion => { :in => 1..99, :message => ' must be 1..99' }
   
   scope :package_first, joins(:item).order('items.is_package_proxy DESC, created_at ASC')
   
   def ext_cost
      cost * quantity
   end
   
end