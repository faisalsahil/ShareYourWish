class AddPostsCategoryIdToPosts < ActiveRecord::Migration
 def self.up
    change_table :posts do |t|
      t.references :posts_category, :after => :content
    end
    execute "UPDATE posts SET posts_category_id=1;"
  end
  def self.down
    remove_column :posts, :posts_category_id
  end
end
