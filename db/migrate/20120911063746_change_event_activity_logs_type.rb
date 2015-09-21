class ChangeEventActivityLogsType < ActiveRecord::Migration
  def up
  	remove_column :event_activity_logs, :type
  	add_column :event_activity_logs, :type_of, :integer

  	add_index :event_activity_logs, :type_of
    add_index :event_activity_logs, :is_internal
    add_index :event_activity_logs, :created_at
  end

  def down
  	remove_index  :event_activity_logs, :type_of
  	remove_index  :event_activity_logs, :is_internal
  	remove_index  :event_activity_logs, :created_at
  	remove_column :event_activity_logs, :type
  	add_column :event_activity_logs, :type_of, :integer
  end
end
