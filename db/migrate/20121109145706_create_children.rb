class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.date :dob
      t.references :guest
      t.references :event

      t.timestamps
    end
    add_index :children, :guest_id
    add_index :children, :event_id
  end
end
