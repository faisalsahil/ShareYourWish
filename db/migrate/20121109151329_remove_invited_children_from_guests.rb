class RemoveInvitedChildrenFromGuests < ActiveRecord::Migration
  def up
   # do a data migration and then manually drop this column
   # remove_column :guests, :invited_children
  end

  def down
   # add_column :guests, :invited_children, :string
  end
end
