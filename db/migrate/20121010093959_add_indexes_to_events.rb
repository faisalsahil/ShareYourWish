class AddIndexesToEvents < ActiveRecord::Migration
  def change
    add_index :events, :location_name
    add_index :events, :child_full_name
    add_index :events, :title
  end
end
