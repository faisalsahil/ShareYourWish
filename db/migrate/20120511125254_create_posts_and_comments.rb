class CreatePostsAndComments < ActiveRecord::Migration
  def up
     
     create_table "Posts" do |t|
         t.string   "title"
         t.string   "tags"
         t.text	   "content"
      end
      
      
  end

  def down
     drop_table "Posts"
  end
  
end
