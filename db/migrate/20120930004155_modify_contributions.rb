class ModifyContributions < ActiveRecord::Migration
  def up
     remove_column :contributions, :message
     add_column :contributions, :cc_type, :string
     add_column :contributions, :cc_num, :string
     add_column :contributions, :cc_exp_month, :integer
     add_column :contributions, :cc_exp_year, :integer
     add_column :contributions, :cc_cvv, :integer
     add_column :contributions, :cc_postal_code, :string
     add_column :contributions, :cc_processing_status, :string, :default=>'awaiting processing'
  end

  def down
     add_column :contributions, :message, :string
     remove_column :contributions, :cc_type
     remove_column :contributions, :cc_num
     remove_column :contributions, :cc_exp_month
     remove_column :contributions, :cc_exp_year
     remove_column :contributions, :cc_cvv
     remove_column :contributions, :cc_postal_code
     remove_column :contributions, :cc_processing_status
  end
end
