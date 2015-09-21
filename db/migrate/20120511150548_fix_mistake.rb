class FixMistake < ActiveRecord::Migration
  def up
     #remove_column :Posts, :post_id
      #add_column :Comments, :post_id, :integer
  end

  def down
  end
end
