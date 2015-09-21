class AddDeletedAtToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :deleted_at, :datetime

  end
end
