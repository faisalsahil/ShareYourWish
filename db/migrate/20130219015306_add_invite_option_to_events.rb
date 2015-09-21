class AddInviteOptionToEvents < ActiveRecord::Migration
  def change
     add_column :events, :invite_option, :string
  end
end
