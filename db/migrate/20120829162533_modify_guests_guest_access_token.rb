class ModifyGuestsGuestAccessToken < ActiveRecord::Migration
  def up
     change_column :guests, :guest_access_token, :string
  end

  def down
  	change_column :guests, :guest_access_token, :integer
  end
end
