class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.integer :sequence, :limit => 2, :default => 0

      t.timestamps
    end
    add_index :posts_categories, :slug, unique: true
    add_index :posts_categories, :sequence
    PostsCategory.create([
      {:name => 'Our Blog', :description => 'Our Blog Description', :sequence => 0},
      {:name => 'Tips and Tools', :description => 'Tips and Tools Description', :sequence => 1},
      {:name => 'In The News', :description => 'In The News Description', :sequence => 2},
    ]) unless PostsCategory.exists?
  end
end
