class AddDeletedAtToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :deleted_at, :datetime

  end
end
