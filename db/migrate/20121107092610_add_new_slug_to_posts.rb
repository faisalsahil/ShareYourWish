class AddNewSlugToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :slug, :string, :after => :title
    add_index :posts, :slug, :unique => true
    Post.find_each(&:save)
  end

  def down
    remove_column :posts, :slug
  end
end
