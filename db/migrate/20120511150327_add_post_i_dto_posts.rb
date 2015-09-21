class AddPostIDtoPosts < ActiveRecord::Migration
  def up
     add_column :Comments, :post_id, :integer
  end

  def down
  end
end
