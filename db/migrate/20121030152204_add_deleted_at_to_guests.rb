class AddDeletedAtToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :deleted_at, :datetime

  end
end
