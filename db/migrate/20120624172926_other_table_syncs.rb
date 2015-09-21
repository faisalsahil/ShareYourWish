class OtherTableSyncs < ActiveRecord::Migration
  def up
     rename_column :charities, :ntee_code, :lookup_charity_code_id
     remove_column :charities, :icon_picture_id
     rename_table :events_charities, :charities_events
     rename_table :packages_items, :items_packages
  end

  def down
  end
end
