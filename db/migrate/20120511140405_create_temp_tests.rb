class CreateTempTests < ActiveRecord::Migration
  def change
    create_table :temp_tests do |t|

      t.timestamps
    end
  end
end
