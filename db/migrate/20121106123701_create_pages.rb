class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :teaser, :null => true
      t.text :text
      t.string :slug
      t.integer :order, :limit => 3, :default => 0
      t.boolean :show_in_menu, :default => false

      t.timestamps
    end
    add_index :pages, :order
    add_index :pages, :show_in_menu
    add_index :pages, :slug
  end
end
