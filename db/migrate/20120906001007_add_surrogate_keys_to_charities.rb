class AddSurrogateKeysToCharities < ActiveRecord::Migration
  def change
     add_column :charities, :syw_altkey, :string
     add_column :charities, :vendor1_altkey, :string
     add_column :charities, :vendor2_altkey, :string
     
     add_index :charities, :syw_altkey, :name => "index_charities_syw_altkey_uq", :unique => true
     add_index :charities, :vendor1_altkey, :name => "index_charities_vendor1_altkey_uq", :unique => true
     add_index :charities, :vendor2_altkey, :name => "index_charities_vendor2_altkey_uq", :unique => true
       
  end
end
