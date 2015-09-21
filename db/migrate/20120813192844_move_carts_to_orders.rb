class MoveCartsToOrders < ActiveRecord::Migration
  def up
     
     add_column :items, :taxable, :boolean, :default=>true, :null=>false
     add_column :items, :is_package_proxy, :boolean, :default=>false, :null=>false
     add_column :items, :is_visible, :boolean, :default=>true, :null=>false

     drop_table   :orders
     
     create_table :orders do |t|
        t.integer :user_id, :null => false
        t.integer :event_id, :null => false
        t.integer :billing_address_id
        t.integer :shipping_address_id
        t.integer :shipping_method_code, :default=>'ground', :null=>false
        t.string  :order_status_code, :default=>'cart', :null=>false
        t.decimal :tax_total_cost, :precision=> 8, :scale=> 2, :default=>0, :null=> false
        t.decimal :shipping_total_cost, :precision=> 8, :scale=> 2,:default=>0, :null=> false
        t.decimal :adjustments_total_cost, :precision=> 8, :scale=> 2,:default=>0, :null=> false
        t.decimal :total_cost, :precision=> 8, :scale=> 2, :default=> 0, :null=> false
        t.text  :customer_notes
        t.text  :internal_notes
        t.timestamps
      end
      
     create_table :lookup_order_status, :id => false do |t|  
         t.string :order_status_code, :null => false
         t.string :order_status_friendly_text, :null => false
     end

     
     create_table :shipments do |t|
        t.integer :order_id, :null => false
        t.integer :shipping_method_code
        t.string  :shipment_tracking_number
        t.string  :special_instructions
        t.datetime :shipment_date
        t.text    :internal_notes
        t.timestamps
      end
      
      create_table :lookup_shipping_methods, :id => false do |t|
         t.string :shipping_method_code, :null => false
         t.string :shipping_method_friendly_text, :null => false
      end
   
      create_table :states do |t|
         t.string :name, :null => false
         t.string :abbr, :null => false
      end
      
      create_table :payments do |t|
         t.integer   :order_id, :null => false
         t.decimal   :amount, :precision=>8, :scale=>2, :default=>0, :null=>false
         t.string    :payment_method, :null=> false
         t.string    :last_four_digits
         t.string    :processing_response
         t.string    :status
      end
      
      create_table :addresses do |t|
         t.integer   :user_id, :null => false
         t.string    :first_name
         t.string    :last_name
         t.string    :company_name
         t.string    :address_1
         t.string    :address_2
         t.string    :city
         t.integer   :state_id
         t.string    :postal_code
      end
      
      
      
  end

  def down
     remove_column :items, :taxable
     remove_column :items, :is_package_proxy
     remove_column :items, :is_visible
     drop_table :orders
     create table :orders do |t|
        t.integer :event_id
        t.integer :user_id
       end
     drop_table :lookup_order_status
     drop_table :shipments
     drop_table :lookup_shipping_methods
     drop_table :states
     drop_table :payments
     drop_table :addresses
  end
end
