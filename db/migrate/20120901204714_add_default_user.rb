class AddDefaultUser < ActiveRecord::Migration
  def up
     Guest.create!(:id => Guest::ANONYMOUS_ID, :full_name => "Default Guest", :email => 'default@guest.com')
     # This migration didn't work, still auto-incremented id. So, had to do a manual database UPDATE to set the id
     # attr_accessible for guest :id
  end

  def down
  end
end
