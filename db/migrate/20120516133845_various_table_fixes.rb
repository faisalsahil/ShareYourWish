class VariousTableFixes < ActiveRecord::Migration
  def up
     
     rename_column :users, :fullname, :full_name
     rename_column :users, :displayname, :display_name
     rename_column :users, :isadmin, :is_admin
     rename_column :users, :displayname, :user_name       
     add_column :users, :language, :string, :default => :en      
     add_index :users, :is_admin
     add_column :users, :is_under_age, :boolean, :default=>0
     add_index :users, :is_under_age
     
     change_column :packages, :cost, :decimal, :precision => 8, :scale => 2

     add_index :pictures, :sort_order      

     change_column :events, :parental_consent_status, :string, :null => true, :default => :notConfirmed    
     change_column :events, :page_alias, :string, :limit => 255     
     change_column :events, :magic_phrase, :string, :limit => 255  
     add_column :events, :status, :string, :limit => 15, :default => :in_progress              
     add_index :events, :event_date
     add_index :events, :child_dob
     add_index :events, :status

     add_index :charities, :name_alias
     add_index :charities, :ntee_code
     
     add_index :carts, :quantity      

     create_table :steps do |t|
       t.string :title, :limit => 255
       t.text :description
       t.integer :order, :default => 0, :limit => 2
       t.integer :completness_of, :null => true
      t.string :slug, :null => true
       t.timestamps
     end
     add_index :steps, :order
     add_index :steps, :completness_of   

     change_column :guests, :status_id, :integer, :default => 0    
     change_column :guests, :hidden, :boolean, :default => false
     add_index :guests, :status_id
     add_index :guests, :hidden

     change_column :lookup_guests_statuses, :status_code, :string, :default => :inviteNotSent          
     add_index :lookup_guests_statuses, :status_code           


     
     
     
     
     
  end

  def down
  end
end
