class ChangeComments < ActiveRecord::Migration
  def self.up
    change_table(:comments) do |t|
      t.references :guest, :null => true
    end
    remove_column :comments, :post_id
    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
    add_index :comments, :guest_id
    add_index :comments, :user_id
  end

  def self.down
    remove_index  :comments, :commentable_type
    remove_index  :comments, :commentable_id
    remove_index  :comments, :guest_id
    remove_index  :comments, :user_id
    add_column    :comments, :post_id, :integer
    remove_column :comments, :guest_id
  end
end
