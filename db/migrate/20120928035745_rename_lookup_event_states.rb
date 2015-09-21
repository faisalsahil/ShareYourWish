class RenameLookupEventStates < ActiveRecord::Migration
  def up
     rename_table :lookup_event_states, :lookup_event_sequences
  end

  def down
  end
end
