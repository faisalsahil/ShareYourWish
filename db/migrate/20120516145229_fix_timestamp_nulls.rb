class FixTimestampNulls < ActiveRecord::Migration
  def up
     
     change_column :authentications, :created_at, :datetime, :null => false
     change_column :authentications, :updated_at, :datetime, :null => false     
     change_column :carts, :created_at, :datetime, :null => false     
     change_column :carts, :updated_at, :datetime, :null => false     
     change_column :carts_archive, :created_at, :datetime, :null => false
     change_column :carts_archive, :updated_at, :datetime, :null => false
     change_column :charities, :created_at, :datetime, :null => false     
     change_column :charities, :updated_at, :datetime, :null => false     
     change_column :comments, :created_at, :datetime, :null => false     
     change_column :comments, :updated_at, :datetime, :null => false
     change_column :events, :created_at, :datetime, :null => false
     change_column :events, :updated_at, :datetime, :null => false     
     change_column :events_log, :created_at, :datetime, :null => false     
     change_column :events_log, :updated_at, :datetime, :null => false     
     change_column :gifts, :created_at, :datetime, :null => false
     change_column :gifts, :updated_at, :datetime, :null => false
     change_column :guests, :created_at, :datetime, :null => false     
     change_column :guests, :updated_at, :datetime, :null => false     
     change_column :items, :created_at, :datetime, :null => false     
     change_column :items, :updated_at, :datetime, :null => false
     change_column :packages, :created_at, :datetime, :null => false
     change_column :packages, :updated_at, :datetime, :null => false
     change_column :pictures, :created_at, :datetime, :null => false     
     change_column :pictures, :updated_at, :datetime, :null => false     
     change_column :posts, :created_at, :datetime, :null => false     
     change_column :posts, :updated_at, :datetime, :null => false     
     change_column :subscribers, :created_at, :datetime, :null => false
     change_column :subscribers, :updated_at, :datetime, :null => false
     change_column :users, :created_at, :datetime, :null => false     
     change_column :users, :updated_at, :datetime, :null => false     
     change_column :authentications, :created_at, :datetime, :null => false     
     change_column :authentications, :updated_at, :datetime, :null => false     

  end

  def down
  end
end
