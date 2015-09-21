class ChangePaymentsOrderId < ActiveRecord::Migration
 def self.up
    change_table :payments do |t|
      t.change :order_id, :string, :null => true
    end
  end
  def self.down
    change_table :payments do |t|
      t.change :order_id, :integer, :null => false
    end
  end
end
