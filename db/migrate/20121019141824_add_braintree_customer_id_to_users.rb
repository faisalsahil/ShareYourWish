class AddBraintreeCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :braintree_customer_id, :integer, :null => true
  end
end
