class ReviseCart < ActiveRecord::Migration
  def up
     remove_column :carts, :item_id
     remove_column :carts, :quantity
     add_column :carts, :user_id, :integer
     add_index :carts, ["event_id"], :name => "index_carts_on_event_id"
     add_index :carts, ["user_id"], :name => "index_carts_on_user_id"
     
     create_table :line_items do |t|
        t.integer :cart_id
        t.integer :order_id
        t.integer :item_id
        t.integer :quantity, default: 1
        t.decimal :cost, :precision=> 8,:scale=> 2

        t.timestamps
      end
     
     create_table :orders do |t|
         t.integer :user_id
         t.integer :event_id

         t.timestamps
       end
     
  end

  def down
  end
end
