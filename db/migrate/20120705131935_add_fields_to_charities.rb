class AddFieldsToCharities < ActiveRecord::Migration
  def self.up
    add_column :charities, :featured, :boolean, :default => false
    add_column :charities, :top_recommended, :boolean, :default => false
    add_index :charities, :featured
    add_index :charities, :top_recommended
  end

  def self.down
    remove_column :charities, :featured
    remove_column :charities, :top_recommended
    remove_index :charities, :featured
    remove_index :charities, :top_recommended
  end
end
