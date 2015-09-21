class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|

      t.references :user, :null => true
      t.string :name
      t.string :email
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
