class AddContributionIdToPayments < ActiveRecord::Migration
  def self.up
    change_table(:payments) do |t|
      t.references :contribution
    end
  end
  def self.down
    remove_column :payments, :contribution_id
  end
end

