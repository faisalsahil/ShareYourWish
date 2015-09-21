class UpdateSteps < ActiveRecord::Migration
  def up
     
     drop_table "steps"
     
     create_table "steps", :force => true do |t|
       t.string   "title"
       t.text     "description"
       t.integer  "order",                :limit => 2, :default => 0
       t.string   "slug"
       t.boolean  "locked_on_completion",              :default => false
       t.boolean  "must_complete",                     :default => false
       t.datetime "created_at",                                           :null => false
       t.datetime "updated_at",                                           :null => false
     end

     add_index "steps", ["order"], :name => "index_steps_on_order"
     
     
  end

  def down
  end
end
