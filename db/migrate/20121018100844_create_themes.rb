class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes, :primary_key => :code do |t|
      t.string :code
      t.string :friendly_name
      t.boolean :is_premium, :default=> false
      t.decimal :cost, :precision => 8, :scale => 2, :default => 0

      t.timestamps
    end
    change_column :themes, :code, :string, :limit => 25
  end
  def self.down
    drop_table :themes
  end
end