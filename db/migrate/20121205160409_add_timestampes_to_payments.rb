class AddTimestampesToPayments < ActiveRecord::Migration
  def self.up
    change_table :payments do |t|
      t.timestamps
    end
  end
  def self.down
    remove_column :payments, :created_at
    remove_column :payments, :updated_at
  end
end
