class AddToUsers < ActiveRecord::Migration
  def up     
     add_column :users, :fullname, :string,  :null => false
     add_column :users, :displayname, :string
     add_column :users, :isadmin, :boolean, :default => false
     add_column :users, :cached_slug, :string
     
  end

  def down
     drop_column :users, :fullname
     drop_column :users, :displayname
     drop_column :users, :isadmin
     drop_column :users, :cached_slug
  end
end
