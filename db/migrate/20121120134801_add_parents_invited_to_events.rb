class AddParentsInvitedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :parents_invited, :string, :default => Event::PARENTS_INVITED.keys[1]
  end
end
