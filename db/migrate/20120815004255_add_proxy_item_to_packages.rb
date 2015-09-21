class AddProxyItemToPackages < ActiveRecord::Migration
  def change
     add_column :packages, :proxy_item_id, :integer
  end
end
