class DropOldTables < ActiveRecord::Migration
  def up
     execute "DROP TABLE IF EXISTS featured_charities"
     execute "DROP TABLE IF EXISTS gifts"
  end

  def down
     # no undo, these are old tables, never used
  end
end
