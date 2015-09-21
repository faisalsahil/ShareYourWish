class AddSortOrderToItems < ActiveRecord::Migration
  def change
    add_column :items, :sort_order, :integer, :default=>1, :null => false

  end
end
