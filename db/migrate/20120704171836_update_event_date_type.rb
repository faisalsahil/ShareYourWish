class UpdateEventDateType < ActiveRecord::Migration
  def up
     change_column :events, :event_date, :datetime
     change_column :events, :child_dob, :datetime
     add_column :events, :child_gender, :string
     add_column :events, :location_name, :string
     add_column :events, :location_address, :string
  end

  def down
  end
end
