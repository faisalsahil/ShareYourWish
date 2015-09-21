class AddRsvpByToEvents < ActiveRecord::Migration
  def change
    add_column :events, :rsvp_by, :date, :null => true
  end
end
