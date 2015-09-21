class RenameCharitiesAlias < ActiveRecord::Migration
  def up
     rename_column :charities, :alias, :name_alias
  end

  def down
  end
end
