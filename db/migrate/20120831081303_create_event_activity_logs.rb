class CreateEventActivityLogs < ActiveRecord::Migration
	def change
		create_table :event_activity_logs do |t|
			t.text :message
			t.boolean :is_internal, :default => true
			t.integer :type
			t.references :event

			t.timestamps
		end
		add_index :event_activity_logs, :event_id
	end
end
