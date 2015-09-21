class AddTermsOfUseToUsers < ActiveRecord::Migration
  def change
     add_column :users, :terms_of_use, :boolean, :default => false
     add_column :users, :subscriber_opt_in, :boolean, :default => false    
  end
end
