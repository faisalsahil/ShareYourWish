class CreateLookupEventStates < ActiveRecord::Migration
  def change
    create_table :lookup_event_states do |t|
      t.string :code
      t.integer :sequence, :default => 0, :limit => 1
      t.text :friendly_text

      t.timestamps
    end
    add_index :lookup_event_states, :code
    add_index :lookup_event_states, :sequence
  end
end
