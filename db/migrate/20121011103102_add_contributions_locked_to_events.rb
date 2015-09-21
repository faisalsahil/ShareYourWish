class AddContributionsLockedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :contributions_locked, :boolean, :default => false
  end
end
