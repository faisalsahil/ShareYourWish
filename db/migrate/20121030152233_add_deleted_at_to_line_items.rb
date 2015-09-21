class AddDeletedAtToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :deleted_at, :datetime

  end
end
