class AddPubliclyViewableToEvents < ActiveRecord::Migration
  def change
    add_column :events, :publicly_viewable, :boolean, :default => false, :after => :state
  end
end
