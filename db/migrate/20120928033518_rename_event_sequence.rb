class RenameEventSequence < ActiveRecord::Migration
  def up
     rename_column :events, :lookup_event_state_id, :event_sequence
     remove_column :lookup_event_states, :id
  end

  def down
     # This is a destructive change cannot be undone
  end
end
