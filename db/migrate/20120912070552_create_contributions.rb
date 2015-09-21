class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :amount, :default => 0
      t.text :message
      t.boolean :anonymous, :default => false
      t.references :charity
      t.references :guest
      t.references :event

      t.timestamps
    end
    add_index :contributions, :charity_id
    add_index :contributions, :guest_id
    add_index :contributions, :event_id
  end
end
