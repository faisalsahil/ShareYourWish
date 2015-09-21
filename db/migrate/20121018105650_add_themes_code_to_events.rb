class AddThemesCodeToEvents < ActiveRecord::Migration
  def self.up
    change_table(:events) do |t|
      t.string :theme_code, :default => 'default'
    end
    add_index :events, :theme_code
  end
  def self.down
    remove_column :events, :theme
  end
end
