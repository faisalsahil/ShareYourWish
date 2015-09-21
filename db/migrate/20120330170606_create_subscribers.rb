class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.text :fullname
      t.text :email
      t.text :comment

      t.timestamps
    end
  end
end
