class AddLocksToEvents < ActiveRecord::Migration
  def change
    add_column :events, :gift_fund_locked, :boolean, :default => true
    add_column :events, :donation_fund_locked, :boolean, :default => true
  end
end
