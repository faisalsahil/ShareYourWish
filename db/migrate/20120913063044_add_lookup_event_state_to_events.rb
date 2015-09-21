class AddLookupEventStateToEvents < ActiveRecord::Migration
  def self.up
    change_table(:events) do |t|
      t.references :lookup_event_state, :default => 1
    end
  end
  def self.down
    remove_column :events, :lookup_event_state_id
  end
end
