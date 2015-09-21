class FixLineItemsCost < ActiveRecord::Migration
  def up
     change_column :line_items, :cost, :decimal, :precision => 8, :scale=> 2, :default => 0, :null => false
  end

  def down
  end
end
