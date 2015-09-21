class SeveralUpdates < ActiveRecord::Migration
  def up
     add_index :guests, :email, :unique => true
     
     drop_table :charities_events
     create_table :charities_events, :id => false do |t|
        t.references :event
        t.references :charity
     end
     
     drop_table :items_packages
     create_table :items_packages, :id => false do |t|
        t.references :package
        t.references :item
     end

     # Re-seed table
     Package.all.each do |package|
       package.items<< Item.limit(3).order('RAND()')
     end

  end

  def down
  end
end
