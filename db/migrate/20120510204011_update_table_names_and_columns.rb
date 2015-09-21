class UpdateTableNamesAndColumns < ActiveRecord::Migration
  def up
     rename_table 'EventsGuests','Guests'
     rename_table 'EventsDonations','Gifts'
     rename_table 'lookup_EventsGuests_Status', 'lookup_Guests_Status'
     add_column :Gifts, :guest_id, :integer
     add_column :Gifts, :charity_id, :integer
     remove_column :Gifts, :event_id
     remove_column :Gifts, :user_id
  end

  def down
  end
end
