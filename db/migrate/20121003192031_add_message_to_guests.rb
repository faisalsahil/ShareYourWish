class AddMessageToGuests < ActiveRecord::Migration
  def change
     add_column :guests, :message, :string
  end
end
