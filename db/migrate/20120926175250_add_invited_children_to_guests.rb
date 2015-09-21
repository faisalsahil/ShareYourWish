class AddInvitedChildrenToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :invited_children, :string
  end
end
