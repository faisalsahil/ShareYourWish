class AddBraintreeCustomerIdToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :braintree_customer_id, :integer, :null => true
  end
end
