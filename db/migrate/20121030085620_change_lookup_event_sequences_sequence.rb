class ChangeLookupEventSequencesSequence < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE lookup_event_sequences ADD PRIMARY KEY (sequence);"
    execute "ALTER TABLE lookup_event_sequences DROP INDEX index_lookup_event_states_on_sequence"
  end
  def self.down
    execute "ALTER TABLE lookup_event_sequences DROP PRIMARY KEY"
    add_index "lookup_event_sequences", ["sequence"], :name => "index_lookup_event_states_on_sequence"
  end
end
