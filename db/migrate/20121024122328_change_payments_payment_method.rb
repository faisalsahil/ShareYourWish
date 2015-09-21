class ChangePaymentsPaymentMethod < ActiveRecord::Migration
 def self.up
    change_table :payments do |t|
      t.change :payment_method, :string, :null => true, :default => Payment::PAYMENT_METHODS[0]
    end
  end
  def self.down
    change_table :payments do |t|
      t.change :payment_method, :string, :null => true
    end
  end
end
