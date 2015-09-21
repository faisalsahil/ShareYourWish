class AddTypeToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :atype, :string, :default => :mailing
  end
end
