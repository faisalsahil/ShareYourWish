class AddHostNameToEvents < ActiveRecord::Migration
  def up
    add_column :events, :host_name, :string, :after => :child_full_name
    Event.find_each{|e| e.update_attribute(:host_name, e.child_full_name) }
  end

  def down
    remove_column :events, :host_name
  end
end
