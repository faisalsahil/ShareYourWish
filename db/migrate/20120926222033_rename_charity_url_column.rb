class RenameCharityUrlColumn < ActiveRecord::Migration
  def up
     rename_column :charities, :url, :website_url
  end

  def down
     rename_column :charities, :website_url, :url
  end
end
