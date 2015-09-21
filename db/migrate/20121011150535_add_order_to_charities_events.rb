class AddOrderToCharitiesEvents < ActiveRecord::Migration
  def change
    add_column :charities_events, :id, :primary_key
  end
end
