class RemovePageTitleFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :page_alias
  end

  def down
    add_column :events, :page_alias, :string, :limit => 255
  end
end
